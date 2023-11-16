import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';

import { SearchHistory } from 'src/entities/search.entity';

@Injectable()
export class SearchRepository {
  constructor(
    @Inject('SEARCH_REPOSITORY')
    private searchRepository: Repository<SearchHistory>,
  ) {}
  async save(searchText: string) {
    console.log(searchText);
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

  async loadEveryHistory() {
    return this.searchRepository.find();
  }
}
