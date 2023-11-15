import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Story } from 'src/entities/story.entity';
import { SearchHistory } from 'src/entities/search.entity';

@Injectable()
export class SearchRepository {
  constructor(
    @Inject('SEARCH_REPOSITORY')
    private storyRepository: Repository<SearchHistory>,
  ) {}
}
