import { Injectable, OnModuleInit } from '@nestjs/common';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SearchRepository } from './search.repository';
import { graphemeCombination, graphemeSeperation } from '../util/util.graphmeModify';
import { Cron, CronExpression } from '@nestjs/schedule';
@Injectable()
export class SearchService implements OnModuleInit {
  constructor(
    private searchHistoryJasoTrie: HistoryJasoTrie,
    private searchRepository: SearchRepository,
  ) {}

  async onModuleInit() {
    await this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    const everyHistory = await this.searchRepository.loadEveryHistory();
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(graphemeSeperation(history.content)));
  }

  insertHistoryToTree(seperatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(seperatedStatement);
  }

  searchHistoryTree(seperatedStatement: string[]): string[] {
    const recommendedWords = this.searchHistoryJasoTrie.search(seperatedStatement, 10);
    return recommendedWords.map((word) => graphemeCombination(word));
  }

  saveHistory(searchText: string) {
    this.searchRepository.save(searchText);
  }
}
