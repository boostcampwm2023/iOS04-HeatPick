import { Injectable, OnModuleInit } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SearchRepository } from './search.repository';
import { StoryJasoTrie } from './trie/storyTrie';
import { StoryRepository } from 'src/story/story.repository';

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
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(this.graphemeSeparation(history.content)));

    const everyStory = await this.storyRepository.loadEveryStory();
    everyStory.forEach((story) => this.storyTitleJasoTrie.insert(this.graphemeSeparation(story.title), story.storyId));
  }

  insertHistoryToTree(separatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(separatedStatement);
  }

  searchHistoryTree(separatedStatement: string[]) {
    const recommendedWords = this.searchHistoryJasoTrie.search(separatedStatement);
    return recommendedWords.map((word) => this.graphemeCombination(word));
  }

  graphemeSeparation(text: string): string[] {
    return Hangul.disassemble(text);
  }

  graphemeCombination(separatedStatement: string[]): string {
    return Hangul.assemble(separatedStatement);
  }

  saveHistory(searchText: string) {
    this.searchRepository.save(searchText);
  }
}
