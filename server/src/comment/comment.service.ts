import { Inject, Injectable } from '@nestjs/common';
import { createCommentEntity } from '../util/util.create.comment.entity';
import { Story } from '../entities/story.entity';
import { User } from '../entities/user.entity';
import { Repository } from 'typeorm';
import { Comment } from '../entities/comment.entity';
import { CommentViewResponseDto, getCommentViewResponse } from './dto/response/comment.view.response.dto';
import { updateComment } from '../util/util.comment.update';
import { Transactional } from 'typeorm-transactional';
import { UserService } from '../user/user.service';
import { StoryService } from '../story/story.service';
import { NotificationService } from '../notification/notification.service';

@Injectable()
export class CommentService {
  constructor(
    @Inject('COMMENT_REPOSITORY')
    private commentRepository: Repository<Comment>,
    private storyService: StoryService,
    private userService: UserService,
    private notificationService: NotificationService,
  ) {}

  @Transactional()
  public async getMentionable({ storyId, userId }): Promise<{ userId: number; username: string }[]> {
    const mentionables: { userId: number; username: string }[] = [];
    const story: Story = await this.storyService.getStory(storyId, ['user', 'comments', 'comments.user', 'comments.mentions']);
    const storyUser = await story.user;
    mentionables.push({ userId: storyUser.userId, username: storyUser.username });
    (await story.comments).forEach((comment) => {
      mentionables.push({ userId: comment.user.userId, username: comment.user.username });
    });

    const following: User[] = await this.userService.getFollows(userId);
    following.forEach((user) => {
      mentionables.push({ userId: user.userId, username: user.username });
    });

    return Array.from(new Set(mentionables.map((user) => user.userId))).map((userId) => {
      return mentionables.find((user) => user.userId === userId);
    });
  }

  @Transactional()
  public async create({ storyId, userId, content, mentions }): Promise<number> {
    const story = await this.storyService.getStory(storyId, ['user']);

    const mentionedUsers: User[] = await Promise.all(
      mentions.map(async (userId: number) => {
        return await this.userService.getUser(userId, ['mentions']);
      }),
    );

    const user = await this.userService.getUser(userId);

    const comment = createCommentEntity(content, user, story);

    await this.commentRepository.save(comment);
    await this.storyService.addCommentCount(storyId);

    for (const mentionedUser of mentionedUsers) {
      await this.userService.mention(mentionedUser, comment);
    }
    try {
      await this.notificationService.sendFcmNotification((await story.user).userId, '댓글 알림💭', `${user.username}님이 ${story.title} 게시글에 댓글을 달았습니다💭`);

      for (const mentionedUser of mentionedUsers) {
        await this.notificationService.sendFcmNotification(mentionedUser.userId, '멘션 알림👥', `${user.username}님이 ${story.title} 게시글에서 멘션했습니다👥`);
      }
    } catch (e) {
      return comment.commentId;
    }
    return comment.commentId;
  }

  @Transactional()
  public async read(storyId: number, userId: number): Promise<CommentViewResponseDto> {
    const story = await this.storyService.getStory(storyId, ['comments', 'comments.user', 'comments.mentions', 'comments.user.profileImage']);
    return await getCommentViewResponse(story, userId);
  }

  @Transactional()
  public async update({ commentId, content, mentions }): Promise<number> {
    const comment: Comment = await this.commentRepository.findOne({ where: { commentId: commentId }, relations: ['mentions', 'mentions.mentions'] });

    const newMentionedUsers: User[] = await Promise.all(
      mentions.map(async (userId: number) => {
        return await this.userService.getUser(userId, ['mentions']);
      }),
    );

    const updatedComment = updateComment(comment, { content });

    for (const originMentionedUser of comment.mentions) {
      await this.userService.unMention(originMentionedUser, comment);
    }

    for (const newMentionedUser of newMentionedUsers) {
      await this.userService.mention(newMentionedUser, updatedComment);
    }

    await this.commentRepository.save(updatedComment);
    return updatedComment.commentId;
  }

  @Transactional()
  public async delete({ storyId, commentId }): Promise<number> {
    const story = await this.storyService.getStory(storyId);
    story.comments = Promise.resolve((await story.comments).filter((comment) => comment.commentId !== commentId));
    await this.storyService.subCommentCount(storyId);

    return commentId;
  }
}
