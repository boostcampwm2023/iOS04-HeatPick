import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';
import { UserRepository } from './../user/user.repository';
import { ImageService } from '../image/image.service';
import { StoryImage } from 'src/entities/storyImage.entity';

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
    private imageService: ImageService,
  ) {}

  public async create({ title, content, images, date }): Promise<number> {
    const savedImagePaths = await Promise.all(images.map(async (image) => await this.imageService.saveImage('../../uploads', image.buffer)));
    const story = new Story();
    story.title = title;
    story.content = content;
    const storyImageArr = await story.storyImages;
    savedImagePaths.forEach((path) => {
      const storyImageObj = new StoryImage();
      storyImageObj.imageUrl = path;
      storyImageArr.push(storyImageObj);
    });
    story.createAt = new Date();
    story.likeCount = 0;

    const user = await this.userRepository.findOneById('zzvyrNHaS1sLw1VeMFwf3tVU3IZLlSVAHQBbETi8DIc');
    const storyList = await user.stories;
    storyList.push(story);
    this.userRepository.createUser(user);
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
}
