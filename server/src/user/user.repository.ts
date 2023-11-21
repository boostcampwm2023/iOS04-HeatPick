import { Inject, Injectable } from '@nestjs/common';
import { FindManyOptions, In, Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';

@Injectable()
export class UserRepository {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
  ) {}

  async save(user: User) {
    this.userRepository.save(user);
  }

  async findByOption(findManyOptions: FindManyOptions) {
    return await this.userRepository.find(findManyOptions);
  }

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

  async findOneByUserId(userId: number) {
    return await this.userRepository.findOne({ where: { userId: userId }, relations: ['profileImage', 'stories', 'stories.storyImages', 'stories.comments'] });
  }
}
