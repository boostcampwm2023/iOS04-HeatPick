import { Injectable } from '@nestjs/common';
import { UserJasoTrie } from './../search/trie/userTrie';
import { UserRepository } from './user.repository';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { Badge } from 'src/entities/badge.entity';
import { AddBadgeDto } from './dto/addBadge.dto';
import { InvalidIdException } from 'src/exception/custom.exception/id.notValid.exception';
import { Story } from '../entities/story.entity';
import { JwtService } from '@nestjs/jwt';
import { ImageService } from '../image/image.service';
import { InvalidBadgeException } from 'src/exception/custom.exception/badge.notValid.exception';
import { nextBadge, strToEmoji } from 'src/util/util.string.to.emoji';
import { AddBadgeExpDto } from './dto/addBadgeExp.dto';
import { UserProfileDetailDataDto } from './dto/user.profile.detail.data.dto';

@Injectable()
export class UserService {
  constructor(
    private userRepository: UserRepository,
    private userJasoTrie: UserJasoTrie,
    private jwtService: JwtService,
    private imageService: ImageService,
  ) {
    this.userRepository.loadEveryUser().then((everyUser) => {
      everyUser.forEach((user) => this.userJasoTrie.insert(graphemeSeperation(user.username), user.userId));
    });
  }

  async getBadges(userRecordId: number) {
    const user = await this.userRepository.findOneByOption({ where: { userId: userRecordId }, relations: ['badges'] });
    const badges = await user.badges;
    return badges;
  }

  async getUsersFromTrie(seperatedStatement: string[], limit: number) {
    const ids = this.userJasoTrie.search(seperatedStatement, limit);
    const users = await this.userRepository.getStoriesByIds(ids);
    return users;
  }

  async addNewBadge(addBadgeDto: AddBadgeDto) {
    const userId = addBadgeDto.userId;
    const badgeName = addBadgeDto.badgeName;

    const userObject = await this.userRepository.findByOption({ where: { userId: userId } });
    if (userObject.length <= 0) throw new InvalidIdException();

    const userBadges = await userObject[0].badges;

    const newBadge = new Badge();
    newBadge.badgeExp = 0;
    newBadge.badgeName = badgeName;
    newBadge.emoji = strToEmoji[badgeName];

    userBadges.push(newBadge);
    this.userRepository.save(userObject[0]);
  }

  async getProfile(oauthId?: string, userId?: number): Promise<UserProfileDetailDataDto> {
    const user = oauthId
      ? await this.userRepository.findOneByOption({ where: { oauthId: oauthId }, relations: ['stories', 'stories.storyImages', 'profileImage'] })
      : await this.userRepository.findOneByOption({ where: { userId: userId }, relations: ['stories', 'stories.storyImages', 'profileImage'] });
    const mainBadge = await user.representativeBadge;
    const stories = await user.stories;

    return {
      username: user.username,
      profileURL: user.profileImage.imageUrl,
      followerCount: 0,
      storyCount: (await user.stories).length,
      experience: 0,
      maxExperience: 999,
      mainBadge: mainBadge,
      storyList: await Promise.all(
        stories.map(async (story: Story) => {
          return { storyId: story.storyId, thumbnailImageURL: (await story.storyImages)[0].imageUrl, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount };
        }),
      ),
    };
  }

  async setRepresentatvieBadge(setBadgeDto: AddBadgeDto) {
    const userId = setBadgeDto.userId;
    const badgeName = setBadgeDto.badgeName;

    const userObject = await this.userRepository.findOneByOption({ where: { userId: userId }, relations: ['representativeBadge'] });
    if (!userObject) throw new InvalidIdException();

    const badgeList = await userObject.badges;
    const targetbadge = badgeList.find((badge) => badge.badgeName === badgeName);
    if (!targetbadge) throw new InvalidBadgeException();
    userObject.representativeBadge = Promise.resolve(null);
    await this.userRepository.save(userObject);

    userObject.representativeBadge = Promise.resolve(targetbadge);

    await this.userRepository.save(userObject);
  }

  async getStoryList(userId: number): Promise<Story[]> {
    const user = await this.userRepository.findOneByUserIdWithStory(userId);
    return await user.stories;
  }

  async update(oauthId: string, image: Express.Multer.File, { username, selectedBadgeId }) {
    const userWithBadges = await this.userRepository.findOneByIdWithBadges(oauthId);
    const badges = await userWithBadges.badges;
    const selectedBadge = badges.filter((badge) => badge.badgeId === selectedBadgeId);
    return await this.userRepository.update({ oauthId: oauthId }, { username: username, representativeBadge: selectedBadge });
  }

  async resign(accessToken: string, message: string) {
    const decodedToken = this.jwtService.verify(accessToken);
    const userId = decodedToken.userId;
    const user = await this.userRepository.findOneByUserId(userId);
    return await this.userRepository.delete(user);
  }

  async addBadgeExp(addBadgeExpDto: AddBadgeExpDto) {
    const userId = addBadgeExpDto.userId;
    const badgeName = addBadgeExpDto.badgeName;
    const exp = addBadgeExpDto.exp;

    const userObject = await this.userRepository.findByOption({ where: { userId: userId } });
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
      const followUser = await this.userRepository.findOneByOption({ where: { userId: followId } });
      const followerUser = await this.userRepository.findOneByOption({ where: { userId: followerId } });

      if (!followerUser.following) followerUser.following = [];
      if (!followUser.followers) followUser.followers = [];

      followerUser.following.push(followUser);
      followUser.followers.push(followerUser);

      this.userRepository.save(followUser);
      this.userRepository.save(followerUser);
    } catch (error) {
      console.log(error);
      throw new InvalidIdException();
    }
  }
  async unFollow(followId: number, followerId: number) {
    try {
      const followUser = await this.userRepository.findOneByOption({ where: { userId: followId } });
      const followerUser = await this.userRepository.findOneByOption({ where: { userId: followerId } });

      if (!followerUser.following) followerUser.following = [];
      if (!followUser.followers) followUser.followers = [];

      followerUser.following = followerUser.following.filter((user) => user.userId !== followId);
      followUser.followers = followUser.followers.filter((user) => user.userId !== followerId);

      this.userRepository.save(followUser);
      this.userRepository.save(followerUser);
    } catch (error) {
      console.log(error);
      throw new InvalidIdException();
    }
  }
  async getFollows(userId: number) {
    const userObj = await this.userRepository.findOneByOption({ where: { userId: userId }, relations: ['following'] });
    const follows = userObj.following;
    //const userIdArray = follows.map((user) => user.userId);
    return follows;
  }

  async getFollowers(userId: number) {
    const userObj = await this.userRepository.findOneByOption({ where: { userId: userId }, relations: ['follower'] });
    const followers = userObj.followers;
    //const userIdArray = follows.map((user) => user.userId);
    return followers;
  }
}
