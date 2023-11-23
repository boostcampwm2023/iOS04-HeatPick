import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';

export class FollowRequest {
  @ApiProperty({ example: '14', description: '유저의 고유 id' })
  @IsNotEmpty({ message: 'followId는 필수 정보입니다.' })
  @IsNumber()
  followId: number;
}
