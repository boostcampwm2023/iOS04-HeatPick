import { Inject, Injectable } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';

@Injectable()
export class UserRepository {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
  ) {}

  async findOneById(id: string): Promise<User> {
    return await this.userRepository.findOne({ where: { oauthId: id } });
  }

  async createUser(user: User) {
    await this.userRepository.save(user);
  }

  async loadEveryUser() {
    return this.userRepository.find();
  }

  async getStoriesByIds(ids: number[]) {
    return await this.userRepository.find({
      where: {
        userId: In(ids),
      },
    });
  }
}
