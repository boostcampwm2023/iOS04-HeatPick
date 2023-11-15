import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';

@Injectable()
export class StoryService {
  constructor(private storyRepository: StoryRepository) {}

  public async create({ title, content, savedImagePaths, date }): Promise<number> {
    const story = new Story();
    story.title = title;
    story.content = content;
    story.storyImageURL = JSON.stringify(savedImagePaths);
    story.createAt = new Date();
    story.likeCount = 0;

    return (await this.storyRepository.addStory(story)).storyId;
  }

  public async read(storyId: number): Promise<StoryDetailViewData> {
    const story: Story = await this.storyRepository.findById(storyId);
    const userData: userDataInStoryView = {
      userId: story.user.userId,
      username: story.user.username,
      profileImageURL: story.user.profileImageURL,
      //badge: story.user.badge
    };

    return {
      story: story,
      author: userData,
    };
  }
}
