import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';

@Injectable()
export class UserRepository {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
  ) {}

  async findOne(id: string): Promise<User> {
    return this.userRepository.findOne({ where: { oauthId: id } });
  }
}
