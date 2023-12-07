import { Injectable, Inject } from '@nestjs/common';
import { Repository } from 'typeorm';
import { SearchHistory } from 'src/entities/search.entity';

import { makeSignature } from 'src/util/make.signature';
import axios from 'axios';

import { Transactional } from 'typeorm-transactional';

@Injectable()
export class SearchService {
  constructor(
    @Inject('SEARCH_REPOSITORY')
    private searchRepository: Repository<SearchHistory>,
  ) {}

  async searchRecommend(searchText: string): Promise<string[]> {
    const [signature, accessKey, timestamp] = makeSignature();

    const options = {
      headers: {
        'x-ncp-apigw-timestamp': timestamp,
        'x-ncp-iam-access-key': accessKey,
        'x-ncp-apigw-signature-v2': signature,
      },
    };

    const AutocompleteSearchQuery = {
      type: 'section',
      query: searchText,
    };

    const url = 'https://cloudsearch.apigw.ntruss.com/CloudSearch/real/v1/domain/heatpick/document/search/autocomplete';
    const data = (await axios.post(url, AutocompleteSearchQuery, options)).data.items;
    return data;
  }

  @Transactional()
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
