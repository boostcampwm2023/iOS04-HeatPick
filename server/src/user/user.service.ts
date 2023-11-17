import { Injectable } from '@nestjs/common';
import { SearchService } from './../search/search.service';
import { UserJasoTrie } from './../search/trie/userTrie';
import { UserRepository } from './user.repository';
import { graphemeSeperation } from 'src/util/util.graphmeModify';

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
}
