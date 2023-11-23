import { ApiProperty } from '@nestjs/swagger';

export class StoryDetailUserDataDto {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  username: string;

  @ApiProperty()
  profileImageUrl: string;

  @ApiProperty()
  status: number; //0 본인 1 언팔 2 팔로우
}
