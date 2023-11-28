import { Inject, Injectable } from '@nestjs/common';
import { FindManyOptions, FindOneOptions, In, Repository } from 'typeorm';
import { Story } from 'src/entities/story.entity';

@Injectable()
export class StoryRepository {
  constructor(
    @Inject('STORY_REPOSITORY')
    private storyRepository: Repository<Story>,
  ) {}

  addStory(story: Story): Promise<Story> {
    return this.storyRepository.save(story);
  }
  async findById(storyId: number): Promise<Story> {
    return await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['category', 'user', 'storyImages', 'user.profileImage', 'badge'] });
  }

  async findOneByIdWithUserAndComments(storyId: number): Promise<Story> {
    return await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['user', 'user.profileImage', 'comments', 'comments.user', 'comments.mentions'] });
  }

  async findOneByOption(findOneOptions: FindOneOptions) {
    return await this.storyRepository.findOne(findOneOptions);
  }

  async saveStory(story: Story) {
    await this.storyRepository.save(story);
  }

  loadEveryStory() {
    return this.storyRepository.find({ relations: ['user'] });
  }

  getStoryByCondition(option: FindManyOptions) {
    return this.storyRepository.find(option);
  }

  async getStoriesByIds(ids: number[]) {
    return await this.storyRepository.find({
      where: {
        storyId: In(ids),
      },
      relations: ['category', 'user'],
    });
  }
}
