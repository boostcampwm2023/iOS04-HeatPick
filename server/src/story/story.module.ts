import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { storyProvider } from 'src/story/story.providers';
import { StoryService } from './story.service';
import { StoryRepository } from './story.repository';

@Module({
  imports: [DatabaseModule],
  controllers: [],
  providers: [...storyProvider, StoryService, StoryRepository],
})
export class StoryModule {}
