import { Inject, Injectable } from '@nestjs/common';
import { FindManyOptions, FindOneOptions, In, Repository } from 'typeorm';
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

  async findOneByOption(findOneByOption: FindOneOptions) {
    return await this.userRepository.findOne(findOneByOption);
  }

  async findByOption(findManyOptions: FindManyOptions) {
    return await this.userRepository.find(findManyOptions);
  }

  async findOneById(id: string): Promise<User> {
    return await this.userRepository.findOne({ where: { oauthId: id } });
  }

  async findOneByIdWithBadges(id: string): Promise<User> {
    return await this.userRepository.findOne({ where: { oauthId: id }, relations: ['badges'] });
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

  async findOneByUserIdWithStory(userId: number) {
    return await this.userRepository.findOne({ where: { userId: userId }, relations: ['profileImage', 'stories', 'stories.storyImages', 'stories.comments'] });
  }

  async findOneByUserIdWithBadge(userId: number) {
    return await this.userRepository.findOne({ where: { userId: userId }, relations: ['badges', 'representativeBadge'] });
  }

  async findOneByUserId(userId: number) {
    return await this.userRepository.findOne({ where: { userId: userId } });
  }

  async update(where: object, elem: object) {
    return await this.userRepository.update(where, elem);
  }

  async delete(user: User) {
    return await this.userRepository.remove(user);
  }
}
