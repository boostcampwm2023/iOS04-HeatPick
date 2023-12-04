import { Inject, Injectable } from '@nestjs/common';
import { createCommentEntity } from '../util/util.create.comment.entity';
import { Story } from '../entities/story.entity';
import { User } from '../entities/user.entity';
import { Repository } from 'typeorm';
import { Comment } from '../entities/comment.entity';
import { CommentViewResponseDto, getCommentViewResponse } from './dto/response/comment.view.response.dto';
import { updateComment } from '../util/util.comment.update';

@Injectable()
export class CommentService {
  constructor(
    @Inject('STORY_REPOSITORY')
    private storyRepository: Repository<Story>,
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
    @Inject('COMMENT_REPOSITORY')
    private commentRepository: Repository<Comment>,
  ) {}

  public async getMentionable({ storyId, userId }): Promise<{ userId: number; username: string }[]> {
    const mentionables: { userId: number; username: string }[] = [];
    const story: Story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['user', 'comments', 'comments.user', 'comments.mentions'] });
    const storyUser = await story.user;
    mentionables.push({ userId: storyUser.userId, username: storyUser.username });
    (await story.comments).forEach((comment) => {
      mentionables.push({ userId: comment.user.userId, username: comment.user.username });
    });

    const user: User = await this.userRepository.findOne({ where: { userId: userId }, relations: ['following'] });
    user.following.forEach((user) => {
      mentionables.push({ userId: user.userId, username: user.username });
    });

    return Array.from(new Set(mentionables.map((user) => user.userId))).map((userId) => {
      return mentionables.find((user) => user.userId === userId);
    });
  }

  public async create({ storyId, userId, content, mentions }): Promise<number> {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId } });

    const mentionedUsers: User[] = await Promise.all(
      mentions.map(async (userId: number) => {
        return await this.userRepository.findOne({ where: { userId: userId }, relations: ['mentions'] });
      }),
    );

    const user = await this.userRepository.findOne({ where: { userId: userId } });

    const comment = createCommentEntity(content, user, story);

    await this.commentRepository.save(comment);
    story.commentCount += 1;
    await this.storyRepository.save(story);

    for (const mentionedUser of mentionedUsers) {
      mentionedUser.mentions = [...mentionedUser.mentions, comment];
      await this.userRepository.save(mentionedUser);
    }

    return comment.commentId;
  }

  public async read(storyId: number, userId: number): Promise<CommentViewResponseDto> {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['comments', 'comments.user', 'comments.mentions', 'comments.user.profileImage'] });
    return await getCommentViewResponse(story, userId);
  }

  public async update({ storyId, commentId, content, mentions }): Promise<number> {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['category', 'user', 'storyImages', 'user.profileImage', 'badge'] });

    const comment: Comment = await this.commentRepository.findOne({ where: { commentId: commentId }, relations: ['mentions', 'mentions.mentions'] });

    const newMentionedUsers: User[] = await Promise.all(
      mentions.map(async (userId: number) => {
        return await this.userRepository.findOne({ where: { userId: userId }, relations: ['mentions'] });
      }),
    );

    const updatedComment = updateComment(comment, { content });

    for (const newMentionedUser of newMentionedUsers) {
      newMentionedUser.mentions = [...newMentionedUser.mentions, updatedComment];
      await this.userRepository.save(newMentionedUser);
    }

    await this.storyRepository.save(story);
    return updatedComment.commentId;
  }

  public async delete({ storyId, commentId }): Promise<number> {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['category', 'user', 'storyImages', 'user.profileImage', 'badge'] });
    story.comments = Promise.resolve((await story.comments).filter((comment) => comment.commentId !== commentId));

    await this.storyRepository.save(story);
    return commentId;
  }
}
