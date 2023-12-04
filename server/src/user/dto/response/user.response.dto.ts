import { ApiProperty } from '@nestjs/swagger';

export class UserResponseDto {
  @ApiProperty({ example: '1', description: 'user의 ID' })
  userId: number;

  @ApiProperty({ example: '아이유', description: '유저의 닉네임' })
  username: string;

  @ApiProperty({ description: ' 유저의 프로필 사진' })
  profileUrl: string;
}

export class UserJsonResponseDto {
  @ApiProperty({ description: '유저 배열', type: UserResponseDto, isArray: true })
  users: UserResponseDto[];
}
