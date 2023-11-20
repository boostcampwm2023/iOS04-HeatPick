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

@Module({
  imports: [DatabaseModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, StoryService, StoryRepository, UserRepository, ImageService, StoryJasoTrie, JwtService],
  exports: [StoryRepository, StoryService],
})
export class StoryModule {}
