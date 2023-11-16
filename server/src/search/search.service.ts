import { Injectable, OnModuleInit } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SearchRepository } from './search.repository';
import { StoryJasoTrie } from './trie/storyTrie';
import { StoryRepository } from '../story/story.repository';
import { Story } from 'src/entities/story.entity';
import { UserRepository } from './../user/user.repository';
import { UserJasoTrie } from './trie/userTrie';
import { User } from 'src/entities/user.entity';

@Injectable()
export class SearchService implements OnModuleInit {
  constructor(
    private searchHistoryJasoTrie: HistoryJasoTrie,
    private storyTitleJasoTrie: StoryJasoTrie,
    private userJasoTrie: UserJasoTrie,
    private searchRepository: SearchRepository,
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
  ) {}
  async onModuleInit() {
    const everyHistory = await this.searchRepository.loadEveryHistory();
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(this.graphemeSeperation(history.content)));

    const everyStory = await this.storyRepository.loadEveryStory();
    everyStory.forEach((story) => this.storyTitleJasoTrie.insert(this.graphemeSeperation(story.title), story.storyId));

    const everyUser = await this.userRepository.loadEveryUser();
    everyUser.forEach((user) => this.userJasoTrie.insert(this.graphemeSeperation(user.username), user.userId));
  }

  insertHistoryToTree(seperatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(seperatedStatement);
  }

  searchHistoryTree(seperatedStatement: string[]): string[] {
    const recommendedWords = this.searchHistoryJasoTrie.search(seperatedStatement);
    return recommendedWords.map((word) => this.graphemeCombination(word));
  }

  async searchStoryTree(seperatedStatement: string[]): Promise<Story[]> {
    const ids = this.storyTitleJasoTrie.search(seperatedStatement);
    const stories = await this.storyRepository.getStoriesByIds(ids);
    return stories;
  }

  async searchUserTree(seperatedStatement: string[]): Promise<User[]> {
    const ids = this.userJasoTrie.search(seperatedStatement);
    const users = await this.userRepository.getStoriesByIds(ids);
    return users;
  }

  graphemeSeperation(text: string): string[] {
    return Hangul.disassemble(text);
  }

  graphemeCombination(separatedStatement: string[]): string {
    return Hangul.assemble(separatedStatement);
  }

  saveHistory(searchText: string) {
    this.searchRepository.save(searchText);
  }
}
