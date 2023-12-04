import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { SearchController } from './search.controller';
import { SearchProvider } from './search.provider';
import { SearchService } from './search.service';
import { HistoryJasoTrie } from './trie/historyTrie';
import { SaveHistoryMiddleware } from './middleware/save.history.middleware';
import { StoryModule } from 'src/story/story.module';
import { UserModule } from 'src/user/user.module';
import { PlaceModule } from 'src/place/place.module';

@Module({
  imports: [DatabaseModule, StoryModule, UserModule, PlaceModule],
  controllers: [SearchController],
  providers: [...SearchProvider, SearchService, HistoryJasoTrie],
})
export class SearchModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(SaveHistoryMiddleware).forRoutes('search/story', 'search/user');
  }
}
