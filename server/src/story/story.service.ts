import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';
import { UserRepository } from '../user/user.repository';
import { createStoryEntity } from '../util/util.create.story.entity';

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
  ) {}

  public async create({ title, content, images, date }): Promise<number> {
    const story = await createStoryEntity({ title, content, images, date });
    const user = await this.userRepository.findOneById('zzvyrNHaS1sLw1VeMFwf3tVU3IZLlSVAHQBbETi8DIc');
    const storyList = await user.stories;
    storyList.push(story);
    await this.userRepository.createUser(user);
    //return (await this.storyRepository.addStory(story)).storyId;
    return 1;
  }

  public async read(storyId: number): Promise<StoryDetailViewData> {
    const story: Story = await this.storyRepository.findById(storyId);
    const user = story.user;
    delete story.user;

    const userData: userDataInStoryView = {
      userId: user.userId,
      username: user.username,
      //profileImageURL: story.user.profileImage.imageUrl,
      //badge: story.user.badge
    };

    return {
      story: story,
      author: userData,
    };
  }

  public async update({ storyId, title, content, images, date }): Promise<number> {
    const story = await createStoryEntity({ title, content, images, date });
    const user = await this.userRepository.findOneById('zzvyrNHaS1sLw1VeMFwf3tVU3IZLlSVAHQBbETi8DIc');
    const storyList = (await user.stories).map((userStory) => {
      if (userStory.storyId === storyId) return story;
      return userStory;
    });
    user.stories = Promise.resolve(storyList);
    await this.userRepository.createUser(user);
    //return (await this.storyRepository.addStory(story)).storyId;
    return 1;
  }
}
