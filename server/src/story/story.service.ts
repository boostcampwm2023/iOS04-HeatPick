import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';
import { UserRepository } from './../user/user.repository';

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
  ) {}

  public async create({ title, content, savedImagePaths, date }): Promise<number> {
    const story = new Story();
    story.title = title;
    story.content = content;
    story.storyImageURL = JSON.stringify(savedImagePaths);
    story.createAt = new Date();
    story.likeCount = 0;

    const testobj = await this.userRepository.findOneById('zzvyrNHaS1sLw1VeMFwf3tVU3IZLlSVAHQBbETi8DIc');
    const storyList = await testobj.stories;
    storyList.push(story);
    this.userRepository.createUser(testobj);
    //return (await this.storyRepository.addStory(story)).storyId;
    return 1;
  }

  public async read(storyId: number): Promise<StoryDetailViewData> {
    const story: Story = await this.storyRepository.findById(storyId);
    const userData: userDataInStoryView = {
      userId: story.user.userId,
      username: story.user.username,
      profileImageURL: story.user.profileImage.imageUrl,
      //badge: story.user.badge
    };

    return {
      story: story,
      author: userData,
    };
  }
}
