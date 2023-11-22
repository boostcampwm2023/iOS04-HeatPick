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
    return comment.commentId;
  }

  public async update({ storyId, commentId, content }) {
    const story = await this.storyRepository.findById(storyId);
    const newComment = createCommentEntity(content);

    story.comments = Promise.resolve(
      (await story.comments).map((comment) => {
        if (comment.commentId === commentId) return newComment;
        return comment;
      }),
    );

    await this.storyRepository.addStory(story);
    return newComment.commentId;
  }

  public async delete({ storyId, commentId }) {
    const story = await this.storyRepository.findById(storyId);
    story.comments = Promise.resolve((await story.comments).filter((comment) => comment.commentId !== commentId));

    await this.storyRepository.addStory(story);
    return commentId;
  }
}
