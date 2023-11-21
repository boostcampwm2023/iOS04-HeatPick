import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { UserService } from './user.service';
import { UserRepository } from './user.repository';
import { UserJasoTrie } from 'src/search/trie/userTrie';
import { userProviders } from './user.providers';
import { UserController } from './user.controller';
import { JwtService } from '@nestjs/jwt';

@Module({
  imports: [DatabaseModule],
  controllers: [UserController],
  providers: [...userProviders, UserService, UserRepository, UserJasoTrie, JwtService],
  exports: [UserService],
})
export class UserModule {}
