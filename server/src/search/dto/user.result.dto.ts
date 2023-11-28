import { ApiProperty } from '@nestjs/swagger';

export class UserResultDto {
  @ApiProperty({ description: '유저의 테이블 고유 Id' })
  userId: number;

  @ApiProperty({ description: '유저의 닉네임' })
  username: string;

  @ApiProperty({ description: '유저 프로필 이미지의 url' })
  profileUrl: string;
}
