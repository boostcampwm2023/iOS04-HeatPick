import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryRepository } from './story.repository';
import { StoryController } from './story.controller';
import { UserRepository } from 'src/user/user.repository';
import { userProviders } from 'src/user/user.providers';

@Module({
  imports: [DatabaseModule],
  controllers: [StoryController],
  providers: [...storyProvider, ...userProviders, StoryService, StoryRepository, UserRepository],
})
export class StoryModule {}
