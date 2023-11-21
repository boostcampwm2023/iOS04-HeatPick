import { Injectable } from '@nestjs/common';
import { SearchService } from './../search/search.service';
import { UserJasoTrie } from './../search/trie/userTrie';
import { UserRepository } from './user.repository';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { User } from 'src/entities/user.entity';
import { Badge } from 'src/entities/badge.entity';
import { AddBadgeDto } from './dto/addBadge.dto';
import { InvalidIdException } from 'src/exception/custom.exception/id.notValid.exception';

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
}
