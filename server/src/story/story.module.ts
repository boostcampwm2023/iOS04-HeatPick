import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryRepository } from './story.repository';
import { StoryController } from './story.controller';
import { UserRepository } from 'src/user/user.repository';
import { userProviders } from 'src/user/user.providers';
import { ImageService } from '../image/image.service';

@Module({
  imports: [DatabaseModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, StoryService, StoryRepository, UserRepository, ImageService],
  exports: [StoryRepository],
})
export class StoryModule {}
