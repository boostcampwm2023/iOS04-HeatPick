import { Injectable } from '@nestjs/common';
import { createCommentEntity } from '../util/util.create.comment.entity';
import { StoryRepository } from '../story/story.repository';
import { UserRepository } from '../user/user.repository';
import { Story } from '../entities/story.entity';
import { User } from '../entities/user.entity';

@Injectable()
export class CommentService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
  ) {}

  public async getMentionable({ storyId, userId }) {
    const mentionables: { userId: number; username: string }[] = [];
    const story: Story = await this.storyRepository.findOneByIdWithUserAndComments(storyId);
    mentionables.push({ userId: story.user.userId, username: story.user.username });

    (await story.comments).forEach((comment) => {
      mentionables.push({ userId: comment.user.userId, username: comment.user.username });
    });

    const user: User = await this.userRepository.findOneByOption({ where: { userId: userId }, relations: ['following'] });
    user.following.forEach((user) => {
      mentionables.push({ userId: user.userId, username: user.username });
    });

    return [...new Set(mentionables)];
  }

  public async create({ storyId, content, mentions }) {
    const story = await this.storyRepository.findById(storyId);

    const mentionedUsers: User[] = mentions.map(async (userId: number) => {
      await this.userRepository.findOneByUserId(userId);
    });

    const comment = createCommentEntity(content, mentionedUsers);

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
