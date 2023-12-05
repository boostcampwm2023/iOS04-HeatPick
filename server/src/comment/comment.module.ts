import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CommentController } from './comment.controller';
import { CommentService } from './comment.service';
import { storyProvider } from '../story/story.providers';
import { userProviders } from '../user/user.providers';
import { CommentProviders } from './comment.providers';
import { UserModule } from '../user/user.module';
import { StoryModule } from '../story/story.module';

@Module({
  imports: [DatabaseModule, UserModule, StoryModule],
  controllers: [CommentController],
  providers: [...storyProvider, ...userProviders, ...CommentProviders, CommentService],
  exports: [],
})
export class CommentModule {}
