import { Injectable, OnModuleInit } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SearchRepository } from './search.repository';
import { graphemeCombination, graphemeSeperation } from '../util/util.graphmeModify';

@Injectable()
export class SearchService {
  constructor(
    private searchHistoryJasoTrie: HistoryJasoTrie,
    private searchRepository: SearchRepository,
  ) {
    this.searchRepository.loadEveryHistory().then((histories) => {
      histories.forEach((history) => this.searchHistoryJasoTrie.insert(graphemeSeperation(history.content)));
    });
  }

  insertHistoryToTree(seperatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(seperatedStatement);
  }

  searchHistoryTree(seperatedStatement: string[]): string[] {
    const recommendedWords = this.searchHistoryJasoTrie.search(seperatedStatement);
    return recommendedWords.map((word) => graphemeCombination(word));
  }

  saveHistory(searchText: string) {
    this.searchRepository.save(searchText);
  }
}
