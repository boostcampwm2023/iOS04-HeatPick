import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';

export class AddBadgeExpDto {
  @ApiProperty({ description: '뱃지의 이름입니다.' })
  badgeName: string;

  @ApiProperty({ description: '유저의 고유 ID입니다.' })
  userId: number;

  @ApiProperty({ description: '증가시킬 경험치 입니다.' })
  @Transform(({ value }) => parseInt(value, 10))
  exp: number;
}
