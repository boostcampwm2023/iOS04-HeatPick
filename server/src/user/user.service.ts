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
import { StoryService } from '../story/story.service';
import { StoryResultDto } from '../search/dto/response/story.result.dto';
import { storyEntityToObjWithOneImg } from '../util/story.entity.to.obj';

@Injectable()
export class UserService {
  private searchUserResultCache = {};

  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
    @Inject(forwardRef(() => StoryService))
    private storyService: StoryService,
    private userJasoTrie: UserJasoTrie,
  ) {
    this.userRepository.find().then((everyUser) => {
      everyUser.forEach((user) => this.userJasoTrie.insert(graphemeSeperation(user.username), user.userId));
    });
  }

  async getUser(userRecordId: number) {
    return await this.userRepository.findOne({ where: { userId: userRecordId } });
  }

  async getBadges(userRecordId: number) {
    const user = await this.userRepository.findOne({ where: { userId: userRecordId }, relations: ['badges'] });
    const badges = await user.badges;
    return badges;
  }

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
    this.userRepository.save(userObject[0]);
  }

  async getProfile(requestUserId: number, targetUserId: number): Promise<UserProfileDetailDataDto> {
    const user = await this.userRepository.findOne({ where: { userId: targetUserId }, relations: ['following', 'followers', 'stories', 'stories.storyImages', 'stories.usersWhoLiked', 'profileImage'] });
    const mainBadge = await user.representativeBadge;
    const stories = await user.stories;
    const userImage = await user.profileImage;
    return {
      userId: user.userId,
      username: user.username,
      profileURL: userImage ? userImage.imageUrl : '',
      isFollow: user.followers.some((user) => user.userId === requestUserId) || requestUserId === targetUserId ? 0 : 1,
      temperature: user.temperature,
      temperatureFeeling: getTemperatureFeeling(user.temperature),
      followerCount: user.followers.length,
      storyCount: (await user.stories).length,
      experience: 0,
      maxExperience: 999,
      mainBadge: mainBadge,
      badgeExplain: strToExplain[mainBadge.badgeName],
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

  async getUpdateMetaData(userId: number): Promise<ProfileUpdateMetaDataDto> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['badges', 'representativeBadge', 'profileImage'] });
    const representativeBadge = await user.representativeBadge;

    const nowBadge: ProfileUpdateMetaBadgeData = {
      ...representativeBadge,
      badgeExplain: strToExplain[representativeBadge.badgeName],
    };

    const badges = await Promise.all(
      (await user.badges).map((badge) => {
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

  async update(userId: number, { image, username, selectedBadgeId }) {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['profileImage', 'badges', 'representativeBadge'] });
    const badges = await user.badges;
    const selectedBadge = badges.find((badge) => badge.badgeId === selectedBadgeId);

    user.username = username;
    user.representativeBadge = Promise.resolve(selectedBadge);
    const profileObj = new profileImage();
    const imageName = await saveImageToLocal('./images/profile', image.buffer);
    profileObj.imageUrl = `https://server.bc8heatpick.store/image/profile?name=${imageName}`;
    user.profileImage = Promise.resolve(profileObj);

    await this.userRepository.save(user);

    return user.userId;
  }

  async resign(userId: number, message: string) {
    return await this.userRepository.softDelete(userId);
  }

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
    this.userRepository.save(userObject[0]);
  }

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
  async getFollows(userId: number) {
    const userObj = await this.userRepository.findOne({ where: { userId: userId }, relations: ['following', 'profileImage'] });
    const follows = userObj.following;
    //const userIdArray = follows.map((user) => user.userId);
    return follows;
  }

  async getFollowers(userId: number) {
    const userObj = await this.userRepository.findOne({ where: { userId: userId }, relations: ['follower'] });
    const followers = userObj.followers;
    //const userIdArray = follows.map((user) => user.userId);
    return followers;
  }
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

  public async like(userId: number, storyId: number): Promise<number> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });
    const story = await this.storyService.getStory(storyId);

    (await user.likedStories).push(story);
    await this.userRepository.save(user);

    return await this.storyService.addLikeCount(storyId);
  }

  public async unlike(userId: number, storyId: number): Promise<number> {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });

    user.likedStories = Promise.resolve((await user.likedStories).filter((story) => story.storyId !== storyId));
    await this.userRepository.save(user);

    return await this.storyService.subLikeCount(storyId);
  }
}
