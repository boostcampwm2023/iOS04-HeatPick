import { ApiProperty } from '@nestjs/swagger';

export class UpdateCommentDto {
  @ApiProperty({ example: '11', description: 'story id' })
  storyId: number;

  @ApiProperty({ example: '22', description: 'comment id' })
  commentId: number;

  @ApiProperty({ example: 'my comment', description: 'comment content' })
  content: string;
}
