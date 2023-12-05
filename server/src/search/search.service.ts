import { Injectable, OnModuleInit, Inject } from '@nestjs/common';
import { HistoryJasoTrie } from './trie/historyTrie';
import { graphemeCombination, graphemeSeperation } from '../util/util.graphmeModify';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Repository } from 'typeorm';
import { SearchHistory } from 'src/entities/search.entity';
import { makeSignature } from 'src/util/make.signature';
import axios from 'axios';
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
    const queryParams = {
      query: '서울',
      type: 'term',
    };
    const [signature, accessKey, timestamp] = makeSignature();
    const headers = {
      'x-ncp-apigw-timestamp': timestamp,
      'x-ncp-iam-access-key': accessKey,
      'x-ncp-apigw-signature-v2': signature,
    };

    const url = 'https://cloudsearch.apigw.ntruss.com/CloudSearch/real/v1/domain/heatpick/document/search/autocomplete';
    axios
      .get(url, { headers, params: queryParams })
      .then((response) => {
        console.log('Status:', response.status);
        console.log('Response:', response.data);
      })
      .catch((error) => {
        console.error('Error:', error.response.status, error.response.data);
      });

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
