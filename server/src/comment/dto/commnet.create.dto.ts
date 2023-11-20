import { ApiProperty } from '@nestjs/swagger';

export class CreateCommentDto {
  @ApiProperty({ example: 'my comment', description: 'comment content' })
  content: string;
}
