import { ApiProperty } from '@nestjs/swagger';

export class UserResponseDto {
  @ApiProperty({ example: '1', description: 'user의 ID' })
  userId: number;

  @ApiProperty({ example: '아이유', description: '유저의 닉네임' })
  username: string;

  @ApiProperty({ description: ' 유저의 프로필 사진' })
  profileURL: string;
}
