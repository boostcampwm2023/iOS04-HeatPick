import { DataSource } from 'typeorm';
import { SearchHistory } from './../entities/search.entity';

export const SearchProvider = [
  {
    provide: 'SEARCH_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(SearchHistory),
    inject: ['DATA_SOURCE'],
  },
];
