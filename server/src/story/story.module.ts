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

@Module({
  imports: [DatabaseModule, forwardRef(() => UserModule)],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, ...CategoryProvider, StoryJasoTrie, StoryService, UserService, CategoryService],
  exports: [StoryService, StoryJasoTrie, CategoryService],
})
export class StoryModule {}
