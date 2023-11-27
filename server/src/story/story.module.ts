import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryRepository } from './story.repository';
import { StoryController } from './story.controller';
import { UserRepository } from 'src/user/user.repository';
import { userProviders } from 'src/user/user.providers';
import { ImageService } from '../image/image.service';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { JwtService } from '@nestjs/jwt';
import { CategoryRepository } from '../category/category.repository';
import { CategoryProvider } from '../category/category.provider';
import { UserService } from 'src/user/user.service';
import { UserModule } from 'src/user/user.module';
import { UserJasoTrie } from 'src/search/trie/userTrie';

@Module({
  imports: [DatabaseModule, UserModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, ...CategoryProvider, UserJasoTrie, UserService, StoryService, StoryRepository, UserRepository, ImageService, StoryJasoTrie, JwtService, CategoryRepository],
  exports: [StoryRepository, StoryService],
})
export class StoryModule {}
