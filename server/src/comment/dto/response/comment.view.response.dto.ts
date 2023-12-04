import { ApiProperty } from '@nestjs/swagger';
import { CommentViewData } from './comment.view.data';
import { Story } from '../../../entities/story.entity';
import { removeMillisecondsFromISOString } from '../../../util/util.date.format.to.ISO8601';

export class CommentViewResponseDto {
  @ApiProperty({ type: () => [CommentViewData] })
  comments: CommentViewData[];
}

export const getCommentViewResponse = async (story: Story, userId: number): Promise<CommentViewResponseDto> => {
  return {
    comments: await Promise.all(
      (await story.comments).map(async (comment) => {
        return {
          commentId: comment.commentId,
          userId: comment.user.userId,
          userProfileImageURL: (await comment.user.profileImage).imageUrl,
          username: comment.user.username,
          createdAt: removeMillisecondsFromISOString(comment.createdAt.toISOString()),
          mentions: comment.mentions.map((user) => {
            return { userId: user.userId, username: user.username };
          }),
          content: comment.content,
          status: comment.user.userId === userId ? 0 : 1,
        };
      }),
    ),
  };
};
