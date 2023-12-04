import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryController } from './story.controller';
import { userProviders } from 'src/user/user.providers';
import { ImageService } from '../image/image.service';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { JwtService } from '@nestjs/jwt';
import { CategoryProvider } from '../category/category.provider';
import { UserService } from 'src/user/user.service';
import { UserModule } from 'src/user/user.module';
import { UserJasoTrie } from 'src/search/trie/userTrie';

@Module({
  imports: [DatabaseModule, UserModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, ...CategoryProvider, UserJasoTrie, UserService, StoryService, ImageService, StoryJasoTrie, JwtService],
  exports: [StoryService],
})
export class StoryModule {}
