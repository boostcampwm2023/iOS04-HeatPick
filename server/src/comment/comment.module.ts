import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CommentController } from './comment.controller';
import { CommentService } from './comment.service';
import { StoryRepository } from '../story/story.repository';
import { storyProvider } from '../story/story.providers';
import { userProviders } from '../user/user.providers';
import { UserRepository } from '../user/user.repository';

@Module({
  imports: [DatabaseModule],
  controllers: [CommentController],
  providers: [...storyProvider, ...userProviders, CommentService, StoryRepository, UserRepository],
  exports: [],
})
export class CommentModule {}
