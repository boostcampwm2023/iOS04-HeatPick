import { ApiProperty } from '@nestjs/swagger';

export class CreateCommentDto {
  @ApiProperty({ example: '11', description: 'story id' })
  storyId: number;

  @ApiProperty({ example: 'my comment', description: 'comment content' })
  content: string;
}
