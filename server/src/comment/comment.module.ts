import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CommentController } from './comment.controller';
import { CommentService } from './comment.service';
import { storyProvider } from '../story/story.providers';
import { userProviders } from '../user/user.providers';
import { CommentProviders } from './comment.providers';
import { CommentRepository } from './comment.repository';

@Module({
  imports: [DatabaseModule],
  controllers: [CommentController],
  providers: [...storyProvider, ...userProviders, ...CommentProviders, CommentService, CommentRepository],
  exports: [],
})
export class CommentModule {}
