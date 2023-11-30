import { ApiProperty } from '@nestjs/swagger';

class userViewType {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  username: string;
}

export class MentionableResponseDto {
  @ApiProperty({ type: () => [userViewType] })
  mentionables: userViewType[];
}
