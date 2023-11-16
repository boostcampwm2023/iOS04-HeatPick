import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { SearchController } from './search.controller';
import { SearchProvider } from './search.provider';
import { SearchService } from './search.service';
import { SearchRepository } from './search.repository';
import { HistoryJasoTrie } from './trie/historyTrie';
import { StoryJasoTrie } from './trie/storyTrie';

@Module({
  imports: [DatabaseModule],
  controllers: [SearchController],
  providers: [...SearchProvider, SearchService, SearchRepository, HistoryJasoTrie, StoryJasoTrie],
})
export class SearchModule {}
