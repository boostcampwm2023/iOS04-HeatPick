import { ApiProperty } from '@nestjs/swagger';

export class MentionableResponseDto {
  @ApiProperty()
  mentionables: { userId: number; username: string }[];
}
