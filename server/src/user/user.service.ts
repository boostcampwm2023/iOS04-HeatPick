import { Injectable } from '@nestjs/common';
import { UserJasoTrie } from './../search/trie/userTrie';
import { UserRepository } from './user.repository';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { Badge } from 'src/entities/badge.entity';
import { AddBadgeDto } from './dto/addBadge.dto';
import { InvalidIdException } from 'src/exception/custom.exception/id.notValid.exception';

import { userProfileDetailDataType } from './type/user.profile.detail.data.type';

import { InvalidBadgeException } from 'src/exception/custom.exception/badge.notValid.exception';


@Injectable()
export class UserService {
  constructor(
    private userRepository: UserRepository,
    private userJasoTrie: UserJasoTrie,
  ) {
    this.userRepository.loadEveryUser().then((everyUser) => {
      everyUser.forEach((user) => this.userJasoTrie.insert(graphemeSeperation(user.username), user.userId));
    });
  }

  async getUsersFromTrie(seperatedStatement: string[]) {
    const ids = this.userJasoTrie.search(seperatedStatement);
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

    userBadges.push(newBadge);
    this.userRepository.save(userObject[0]);
  }


  async getProfile(userId: number): Promise<userProfileDetailDataType> {
    const user = await this.userRepository.findOneByUserId(userId);
    const userBadges = await user.badges;
    const stories = await user.stories;
    return {
      username: user.username,
      profileURL: user.profileImage.imageUrl,
      followerCount: 0,
      storyCount: (await user.stories).length,
      experience: 0,
      maxExperience: 999,
      badge: userBadges,
      storyList: stories,
    };

  async setRepresentatvieBadge(setBadgeDto: AddBadgeDto) {
    const userId = setBadgeDto.userId;
    const badgeName = setBadgeDto.badgeName;

    const userObject = await this.userRepository.findByOption({ where: { userId: userId } });
    if (userObject.length <= 0) throw new InvalidIdException();

    const badgeList = await userObject[0].badges;
    const targetbadge = badgeList.find((badge) => badge.badgeName === badgeName);
    if (!targetbadge) throw new InvalidBadgeException();

    userObject[0].representativeBadge = targetbadge;
    this.userRepository.save(userObject[0]);

  }
}
