import { forwardRef, Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { UserService } from './user.service';
import { UserJasoTrie } from 'src/search/trie/userTrie';
import { userProviders } from './user.providers';
import { UserController } from './user.controller';;
import { StoryModule } from '../story/story.module';
import { storyProvider } from '../story/story.providers';
import { NotificationModule } from '../notification/notification.module';

@Module({
  imports: [DatabaseModule, forwardRef(() => StoryModule), NotificationModule],
  controllers: [UserController],
  providers: [...userProviders, ...storyProvider, UserService, UserJasoTrie],
  exports: [UserService, UserJasoTrie],
})
export class UserModule {}
