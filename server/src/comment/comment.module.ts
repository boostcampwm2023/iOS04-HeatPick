import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CommentController } from './comment.controller';
import { CommentService } from './comment.service';
import { StoryRepository } from '../story/story.repository';
import { storyProvider } from '../story/story.providers';

@Module({
  imports: [DatabaseModule],
  controllers: [CommentController],
  providers: [...storyProvider, CommentService, StoryRepository],
  exports: [],
})
export class CommentModule {}
