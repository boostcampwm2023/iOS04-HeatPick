import { Injectable, Inject, forwardRef } from '@nestjs/common';
import { UserJasoTrie } from './../search/trie/userTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { Badge } from 'src/entities/badge.entity';
import { AddBadgeDto } from './dto/request/addBadge.dto';
import { InvalidIdException } from 'src/exception/custom.exception/id.notValid.exception';
import { Story } from '../entities/story.entity';
import { InvalidBadgeException } from 'src/exception/custom.exception/badge.notValid.exception';
import { nextBadge, strToEmoji, strToExplain } from 'src/util/util.string.to.badge.content';
import { AddBadgeExpDto } from './dto/request/addBadgeExp.dto';
import { UserProfileDetailDataDto } from './dto/response/user.profile.detail.data.dto';
import { getTemperatureFeeling } from '../constant/temperature';
import { User } from 'src/entities/user.entity';
import { profileImage } from '../entities/profileImage.entity';
import { saveImageToLocal } from '../util/util.save.image.local';
import { ProfileUpdateMetaBadgeData } from './dto/response/profile.update.meta.badge.data';
import { ProfileUpdateMetaDataDto } from './dto/response/profile.update.meta.dto';
import { UserProfileDetailStoryDto } from './dto/response/user.profile.detail.story.dto';
import { In, Repository } from 'typeorm';
import { Transactional } from 'typeorm-transactional';
import { StoryService } from '../story/story.service';
import { Comment } from '../entities/comment.entity';
import { NotificationService } from '../notification/notification.service';
import { dateFormatToISO8601 } from '../util/util.date.format.to.ISO8601';
import { calculateTemperature } from 'src/util/calculate.temper';

@Injectable()
export class UserService {
  private searchUserResultCache = {};

  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
    @Inject(forwardRef(() => StoryService))
    private storyService: StoryService,
    private userJasoTrie: UserJasoTrie,
    private notificationService: NotificationService,
  ) {
    this.userRepository.find().then((everyUser) => {
      everyUser.forEach((user) => this.userJasoTrie.insert(graphemeSeperation(user.username), user.userId));
    });
  }

  @Transactional()
  async getUser(userRecordId: number, relations?: object) {
    return await this.userRepository.findOne({ where: { userId: userRecordId }, relations: relations });
  }

  @Transactional()
  async getBadges(userRecordId: number) {
    const user = await this.userRepository.findOne({ where: { userId: userRecordId }, relations: ['badges'] });
    const badges = await user.badges;
    return badges;
  }

  @Transactional()
  async getUsersFromTrie(searchText: string, offset: number, limit: number): Promise<User[]> {
    if (!this.searchUserResultCache.hasOwnProperty(searchText)) {
      const seperatedStatement = graphemeSeperation(searchText);
      const ids = this.userJasoTrie.search(seperatedStatement, 100);
      const stories = await this.userRepository.find({
        where: {
          userId: In(ids),
        },
      });
      this.searchUserResultCache[searchText] = stories;
    }

    const results = this.searchUserResultCache[searchText];
    return results.slice(offset * limit, offset * limit + limit);
  }

  @Transactional()
  async addNewBadge(addBadgeDto: AddBadgeDto) {
    const userId = addBadgeDto.userId;
    const badgeName = addBadgeDto.badgeName;

    const userObject = await this.userRepository.find({ where: { userId: userId } });
    if (userObject.length <= 0) throw new InvalidIdException();

    const userBadges = await userObject[0].badges;

    const newBadge = new Badge();
    newBadge.badgeExp = 0;
    newBadge.badgeName = badgeName;
    newBadge.emoji = strToEmoji[badgeName];

    userBadges.push(newBadge);
    await this.userRepository.save(userObject[0]);
  }

  @Transactional()
  async getProfile(requestUserId: number, targetUserId: number): Promise<UserProfileDetailDataDto> {
    const user = await this.userRepository.findOne({ where: { userId: targetUserId }, relations: ['following', 'followers', 'stories', 'stories.storyImages', 'stories.usersWhoLiked', 'profileImage', 'representativeBadge'] });
    const mainBadge = await user?.representativeBadge;
    const stories = await user.stories;
    const userImage = await user.profileImage;
    const temperature = await calculateTemperature(user);
    return {
      userId: user.userId,
      username: user.username,
      profileURL: userImage ? userImage.imageUrl : '',
      isFollow: user.followers.some((user) => user.userId === requestUserId) || requestUserId === targetUserId,
      temperature: temperature,
      temperatureFeeling: getTemperatureFeeling(temperature),
      followerCount: user.followers.length,
      storyCount: (await user.stories).length,
      experience: 0,
      maxExperience: 999,
      mainBadge: mainBadge,
      badgeExplain: strToExplain[mainBadge.badgeName],
      nextBadge: nextBadge[mainBadge.badgeName] || null,
      storyList: (
        await Promise.all(
          stories.map(async (story: Story) => {
            return {
              storyId: story.storyId,
              thumbnailImageURL: (await story.storyImages).length > 0 ? (await story.storyImages)[0].imageUrl : '',
              title: story.title,
              content: story.content,
              likeState: (await story.usersWhoLiked).some((user) => user.userId === requestUserId) ? 0 : 1,
              likeCount: story.likeCount,
              commentCount: story.commentCount,
            };
          }),
        )
      ).slice(0, 5),
    };
  }

  @Transactional()
  async setRepresentatvieBadge(setBadgeDto: AddBadgeDto) {
    const userId = setBadgeDto.userId;
    const badgeName = setBadgeDto.badgeName;

    const userObject = await this.userRepository.findOne({ where: { userId: userId }, relations: ['representativeBadge'] });
    if (!userObject) throw new InvalidIdException();

    const badgeList = await userObject.badges;
    const targetbadge = badgeList.find((badge) => badge.badgeName === badgeName);
    if (!targetbadge) throw new InvalidBadgeException();
    userObject.representativeBadge = Promise.resolve(null);
    await this.userRepository.save(userObject);

    userObject.representativeBadge = Promise.resolve(targetbadge);

    await this.userRepository.save(userObject);
  }

  @Transactional()
  async getStoryList(requestUserId: number, targetUserId: number, offset: number, limit: number): Promise<UserProfileDetailStoryDto[]> {
    const user = await this.userRepository.findOne({ where: { userId: targetUserId }, relations: ['stories', 'stories.storyImages', 'stories.usersWhoLiked'] });
    return (
      await Promise.all(
        (await user.stories).map(async (story: Story) => {
          return {
            storyId: story.storyId,
            thumbnailImageURL: (await story.storyImages)[0].imageUrl,
            title: story.title,
            content: story.content,
            likeState: (await story.usersWhoLiked).some((user) => user.userId === requestUserId) ? 0 : 1,
            likeCount: story.likeCount,
            commentCount: story.commentCount,
          };
        }),
      )
    ).slice(offset * limit, offset * limit + limit);
  }

  @Transactional()
  async getUpdateMetaData(userId: number): Promise<ProfileUpdateMetaDataDto> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['badges', 'representativeBadge', 'profileImage'] });
    const representativeBadge = await user.representativeBadge;

    const nowBadge: ProfileUpdateMetaBadgeData = {
      ...representativeBadge,
      badgeExplain: strToExplain[representativeBadge.badgeName],
    };

    const badges = await Promise.all(
      (await user.badges)
        .filter((badge) => badge.badgeId !== representativeBadge.badgeId)
        .map((badge) => {
          return {
            ...badge,
            badgeExplain: strToExplain[badge.badgeName],
          };
        }),
    );
    const userImage = await user.profileImage;
    return {
      userId: userId,
      profileImageURL: userImage.imageUrl,
      username: user.username,
      nowBadge: nowBadge,
      badges: badges,
    };
  }

  @Transactional()
  async update(userId: number, { image, username, selectedBadgeId }) {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['profileImage', 'badges', 'representativeBadge'] });
    const badges = await user.badges;
    const selectedBadge = badges.find((badge) => badge.badgeId === selectedBadgeId);

    user.username = username;
    user.representativeBadge = Promise.resolve(selectedBadge);

    if (image) {
      const profileObj = new profileImage();
      profileObj.imageUrl = image ? await saveImageToLocal('./images/profile', image.buffer, 'profile') : ``;
      user.profileImage = Promise.resolve(profileObj);
    }

    await this.userRepository.save(user);

    return user.userId;
  }

  @Transactional()
  async resign(userId: number, message: string) {
    const user: User = await this.userRepository.findOne({
      where: { userId: userId },
      relations: ['badges', 'stories', 'representativeBadge', 'comments', 'following', 'followers', 'following.followers', 'followers.following', 'likedStories'],
      withDeleted: true,
    });

    (await user.stories).map((story) => {
      story.user = null;
      story.deletedAt = dateFormatToISO8601(new Date().toISOString());
      return;
    });

    (await user.comments).map((comment) => {
      comment.user = null;
      comment.deletedAt = dateFormatToISO8601(new Date().toISOString());
      return;
    });

    await Promise.all(
      user.following.map(async (user) => {
        user.followers = user.followers.filter((user) => user.userId !== user.userId);
        await this.userRepository.save(user);
      }),
    );
    await Promise.all(
      user.followers.map(async (user) => {
        user.following = user.following.filter((user) => user.userId !== user.userId);
        await this.userRepository.save(user);
      }),
    );

    await Promise.all(
      (await user.likedStories).map(async (story) => {
        await this.storyService.subLikeCount(story.storyId);
      }),
    );

    user.likedStories = Promise.resolve([]);
    user.badges = Promise.resolve([]);
    user.representativeBadge = Promise.resolve(null);

    await this.userRepository.save(user);

    return await this.userRepository.remove(await this.userRepository.findOne({ where: { userId: userId } }));
  }

  @Transactional()
  async addBadgeExp(addBadgeExpDto: AddBadgeExpDto) {
    const userId = addBadgeExpDto.userId;
    const badgeName = addBadgeExpDto.badgeName;
    const exp = addBadgeExpDto.exp;

    const userObject = await this.userRepository.find({ where: { userId: userId } });
    if (userObject.length <= 0) throw new InvalidIdException();

    const badgeList = await userObject[0].badges;
    const targetbadge = badgeList.find((badge) => badge.badgeName === badgeName);
    if (!targetbadge) throw new InvalidBadgeException();

    targetbadge.badgeExp += exp;

    if (targetbadge.badgeExp >= 100 && nextBadge[targetbadge.badgeName]) {
      targetbadge.badgeName = nextBadge[targetbadge.badgeName];
      targetbadge.emoji = strToEmoji[targetbadge.badgeName];
      targetbadge.badgeExp = 0;
    }
    await this.userRepository.save(userObject[0]);
  }

  @Transactional()
  async addFollowing(followId: number, followerId: number) {
    try {
      const followUser = await this.userRepository.findOne({ where: { userId: followId }, relations: ['following', 'followers'] });
      const followerUser = await this.userRepository.findOne({ where: { userId: followerId }, relations: ['following', 'followers'] });
      followerUser.following.push(followUser);
      followUser.followers.push(followerUser);

      await Promise.all([this.userRepository.save(followUser), this.userRepository.save(followerUser)]);
    } catch (error) {
      console.log(error);
      throw new InvalidIdException();
    }
  }

  @Transactional()
  async unFollow(followId: number, followerId: number) {
    try {
      const followUser = await this.userRepository.findOne({ where: { userId: followId }, relations: ['followers'] });
      const followerUser = await this.userRepository.findOne({ where: { userId: followerId }, relations: ['following'] });

      if (!followerUser.following) followerUser.following = [];
      if (!followUser.followers) followUser.followers = [];

      followerUser.following = followerUser.following.filter((user) => user.userId !== followId);
      followUser.followers = followUser.followers.filter((user) => user.userId !== followerId);

      await this.userRepository.save(followUser);
      await this.userRepository.save(followerUser);
    } catch (error) {
      console.log(error);
      throw new InvalidIdException();
    }
  }

  @Transactional()
  async getFollows(userId: number) {
    const userObj = await this.userRepository.findOne({ where: { userId: userId }, relations: ['following', 'profileImage'] });
    const follows = userObj.following;
    //const userIdArray = follows.map((user) => user.userId);
    return follows;
  }

  @Transactional()
  async getFollowers(userId: number) {
    const userObj = await this.userRepository.findOne({ where: { userId: userId }, relations: ['follower'] });
    const followers = userObj.followers;
    //const userIdArray = follows.map((user) => user.userId);
    return followers;
  }

  @Transactional()
  async recommendUsers(userId: number): Promise<User[]> {
    const users: User[] = await this.userRepository
      .createQueryBuilder('user')
      .leftJoin('user.following', 'following')
      .where('user.userId <> :userId AND following.userId IS NULL AND user.deletedAt IS NULL')
      .orderBy('RAND()')
      .take(20)
      .setParameter('userId', userId)
      .getMany();

    return users;
  }

  @Transactional()
  public async like(userId: number, storyId: number): Promise<number> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });
    const story = await this.storyService.getStory(storyId, ['user']);

    (await user.likedStories).push(story);
    await this.userRepository.save(user);

    try {
      await this.notificationService.sendFcmNotification((await story.user).userId, `좋아요 알림❤️`, `${user.username}님이 ${story.title} 게시글에 좋아요를 눌렀습니다❤️`);
    } catch (e) {
      return await this.storyService.addLikeCount(storyId);
    }
    return await this.storyService.addLikeCount(storyId);
  }

  @Transactional()
  public async unlike(userId: number, storyId: number): Promise<number> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });

    user.likedStories = Promise.resolve((await user.likedStories).filter((story) => story.storyId !== storyId));
    await this.userRepository.save(user);

    return await this.storyService.subLikeCount(storyId);
  }

  @Transactional()
  public async mention(user: User, comment: Comment) {
    user.mentions.push(comment);
    return await this.userRepository.save(user);
  }

  @Transactional()
  public async unMention(user: User, targetComment: Comment) {
    user.mentions = user.mentions.filter((comment) => comment.commentId !== targetComment.commentId);
    return await this.userRepository.save(user);
  }
}
