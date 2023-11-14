import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';

@Injectable()
export class StoryService {
  constructor(private storyRepository: StoryRepository) {}

  public async create({ title, content, imageList, date }): Promise<number> {
    const story = new Story();
    story.title = title;
    story.content = content;
    story.storyImageURL = imageList;
    story.createAt = new Date();
    story.likeCount = 0;

    return (await this.storyRepository.addStory(story)).storyId;
  }
}
