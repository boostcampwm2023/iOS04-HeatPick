import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { SearchController } from './search.controller';
import { SearchProvider } from './search.provider';
import { SearchService } from './search.service';
import { SearchRepository } from './search.repository';
import { JasoTrie } from './trie/trie';

@Module({
  imports: [DatabaseModule],
  controllers: [SearchController],
  providers: [...SearchProvider, SearchService, SearchRepository, JasoTrie],
})
export class SearchModule {}
