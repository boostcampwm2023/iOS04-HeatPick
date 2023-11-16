import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { UserService } from './user.service';
import { UserRepository } from './user.repository';
import { UserJasoTrie } from 'src/search/trie/userTrie';
import { userProviders } from './user.providers';

@Module({
  imports: [DatabaseModule],
  providers: [...userProviders, UserService, UserRepository, UserJasoTrie],
  exports: [UserService],
})
export class UserModule {}
