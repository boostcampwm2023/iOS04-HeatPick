import { forwardRef, Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryController } from './story.controller';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { UserService } from 'src/user/user.service';
import { CategoryService } from '../category/category.service';
import { UserModule } from '../user/user.module';
import { userProviders } from '../user/user.providers';
import { CategoryProvider } from '../category/category.provider';
import { CategoryModule } from '../category/category.module';

@Module({
  imports: [DatabaseModule, forwardRef(() => UserModule), CategoryModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, ...CategoryProvider, StoryJasoTrie, StoryService],
  exports: [StoryService, StoryJasoTrie],
})
export class StoryModule {}
