import { ApiProperty } from '@nestjs/swagger';

export class CommentViewData {
  @ApiProperty()
  commentId: number;

  @ApiProperty()
  userId: number;

  @ApiProperty()
  userProfileImageURL: string;

  @ApiProperty()
  username: string;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  mentions: { userId: number; username: string }[];

  @ApiProperty()
  content: string;

  @ApiProperty()
  status: number;
}
