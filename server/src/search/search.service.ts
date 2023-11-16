import { Injectable, OnModuleInit } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SearchRepository } from './search.repository';
import { StoryJasoTrie } from './trie/storyTrie';
import { StoryRepository } from '../story/story.repository';

@Injectable()
export class SearchService implements OnModuleInit {
  constructor(
    private searchHistoryJasoTrie: HistoryJasoTrie,
    private storyTitleJasoTrie: StoryJasoTrie,
    private searchRepository: SearchRepository,
    private storyRepository: StoryRepository,
  ) {}
  async onModuleInit() {
    const everyHistory = await this.searchRepository.loadEveryHistory();
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(this.graphemeSeperation(history.content)));

    const everyStory = await this.storyRepository.loadEveryStory();

    everyStory.forEach((story) => this.storyTitleJasoTrie.insert(this.graphemeSeperation(story.title), story.storyId));
  }

  insertHistoryToTree(seperatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(seperatedStatement);
  }

  searchHistoryTree(seperatedStatement: string[]): string[] {
    const recommendedWords = this.searchHistoryJasoTrie.search(seperatedStatement);
    return recommendedWords.map((word) => this.graphemeCombination(word));
  }

  searchStoryTree(seperatedStatement: string[]): number[] {
    console.log(seperatedStatement);
    return this.storyTitleJasoTrie.search(seperatedStatement);
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
