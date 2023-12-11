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
    comments: (
      await Promise.all(
        (await story.comments).map(async (comment) => {
          return {
            commentId: comment.commentId,
            userId: comment.user?.userId ? comment.user.userId : -1,
            userProfileImageURL: (await comment.user?.profileImage)?.imageUrl ? (await comment.user.profileImage).imageUrl : '',
            username: comment.user?.username ? comment.user.username : '탈퇴한 유저',
            createdAt: removeMillisecondsFromISOString(comment.createdAt.toISOString()),
            mentions: comment.mentions.map((user) => {
              return { userId: user.userId, username: user.username };
            }),
            content: comment.content,
            status: comment.user?.userId ? (comment.user.userId === userId ? 0 : 1) : -1,
          };
        }),
      )
    ).sort((a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime()),
  };
};
