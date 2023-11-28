import { Inject, Injectable } from '@nestjs/common';
import { FindManyOptions, In, Repository } from 'typeorm';
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
    return await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['user', 'comments', 'comments.user'] });
  }

  async findByOption(findManyOptions: FindManyOptions) {
    return await this.storyRepository.find(findManyOptions);
  }

  async saveStory(story: Story) {
    await this.storyRepository.save(story);
  }

  loadEveryStory() {
    return this.storyRepository.find();
  }

  getStoryByCondition(option: FindManyOptions) {
    return this.storyRepository.find(option);
  }

  async getStoriesByIds(ids: number[]) {
    return await this.storyRepository.find({
      where: {
        storyId: In(ids),
      },
      relations: ['category'],
    });
  }
}
