import { Injectable, OnModuleInit } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { JasoTrie } from './trie/trie';
import { SearchRepository } from './search.repository';

@Injectable()
export class SearchService implements OnModuleInit {
  constructor(
    private searchHistoryJasoTrie: JasoTrie,
    private storyTitleJasoTrie: JasoTrie,
    private searchRepository: SearchRepository,
  ) {}
  async onModuleInit() {
    const everyHistory = await this.searchRepository.loadEveryHistory();
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(this.graphemeSeparation(history.content)));
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
