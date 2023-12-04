import { Injectable, OnModuleInit, Inject } from '@nestjs/common';
import { HistoryJasoTrie } from './trie/historyTrie';
import { graphemeCombination, graphemeSeperation } from '../util/util.graphmeModify';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Repository } from 'typeorm';
import { SearchHistory } from 'src/entities/search.entity';
@Injectable()
export class SearchService implements OnModuleInit {
  constructor(
    private searchHistoryJasoTrie: HistoryJasoTrie,
    @Inject('SEARCH_REPOSITORY')
    private searchRepository: Repository<SearchHistory>,
  ) {}

  async onModuleInit() {
    await this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    const everyHistory = await this.searchRepository.find();
    everyHistory.forEach((history) => this.searchHistoryJasoTrie.insert(graphemeSeperation(history.content)));
  }

  insertHistoryToTree(seperatedStatement: string[]) {
    this.searchHistoryJasoTrie.insert(seperatedStatement);
  }

  searchHistoryTree(seperatedStatement: string[]): string[] {
    const recommendedWords = this.searchHistoryJasoTrie.search(seperatedStatement, 10);
    return recommendedWords.map((word) => graphemeCombination(word));
  }

  async saveHistory(searchText: string) {
    const existingHistory = await this.searchRepository.findOne({ where: { content: searchText } });
    if (existingHistory) {
      existingHistory.count += 1;
      return await this.searchRepository.save(existingHistory);
    }

    const newHistory = new SearchHistory();
    newHistory.content = searchText;
    newHistory.count = 1;
    return await this.searchRepository.save(newHistory);
  }
}
