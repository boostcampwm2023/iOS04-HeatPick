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
  findById(storyId: number): Promise<Story> {
    return this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['user', 'user.profileImage', 'category', 'user.representativeBadge', 'place'] });
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
    });
  }
}
