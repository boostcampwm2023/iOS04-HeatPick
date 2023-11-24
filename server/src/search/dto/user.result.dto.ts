import { ApiProperty } from '@nestjs/swagger';

export class UserResultDto {
  @ApiProperty({ description: '유저의 테이블 고유 Id' })
  userId: string;

  @ApiProperty({ description: '유저의 닉네임' })
  username: string;

  @ApiProperty({ description: '유저의 온도 수' })
  temperature: number;

  @ApiProperty({ description: '유저 생성 시간' })
  createdAt: Date;

  @ApiProperty({ description: '유저의 최근 활동 시간' })
  recentlyActive: Date;

  @ApiProperty({ description: '유저 프로필 이미지의 url' })
  profileImage: string;
}
