import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';

@Injectable()
export class StoryService {
  constructor(private storyRepository: StoryRepository) {}

}
