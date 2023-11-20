import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';
import { UserRepository } from './../user/user.repository';
import { ImageService } from '../image/image.service';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { createStoryEntity } from '../util/util.create.story.entity';
import { Cron, CronExpression } from '@nestjs/schedule';

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
    private imageService: ImageService,
    private storyTitleJasoTrie: StoryJasoTrie,
  ) {
    this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    this.storyRepository.loadEveryStory().then((everyStory) => {
      everyStory.forEach((story) => this.storyTitleJasoTrie.insert(graphemeSeperation(story.title), story.storyId));
    });
  }

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

  async getStoriesFromTrie(seperatedStatement: string[]) {
    const ids = this.storyTitleJasoTrie.search(seperatedStatement);
    const stories = await this.storyRepository.getStoriesByIds(ids);
    return stories;
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

  public async delete(storyId: number) {
    const user = await this.userRepository.findOneById('zzvyrNHaS1sLw1VeMFwf3tVU3IZLlSVAHQBbETi8DIc');
    const storyList = (await user.stories).filter((story) => story.storyId !== parseInt(String(storyId), 10));
    user.stories = Promise.resolve(storyList);
    await this.userRepository.createUser(user);
  }
}
