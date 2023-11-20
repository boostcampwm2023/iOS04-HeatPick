import { Injectable } from '@nestjs/common';
import { createCommentEntity } from '../util/util.create.comment.entity';
import { StoryRepository } from '../story/story.repository';

@Injectable()
export class CommentService {
  constructor(private storyRepository: StoryRepository) {}

  public async create({ storyId, content }) {
    const story = await this.storyRepository.findById(storyId);
    const comment = createCommentEntity(content);

    story.comments = Promise.resolve([...(await story.comments), comment]);
    await this.storyRepository.addStory(story);
    return comment;
  }
}
