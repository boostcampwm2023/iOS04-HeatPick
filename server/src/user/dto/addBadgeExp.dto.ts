import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import { IsNumber, IsString } from 'class-validator';

export class AddBadgeExpDto {
  @ApiProperty({ description: '뱃지의 이름입니다.' })
  @IsString()
  badgeName: string;

  @ApiProperty({ description: '유저의 고유 ID입니다.' })
  @IsNumber()
  userId: number;

  @ApiProperty({ description: '증가시킬 경험치 입니다.' })
  @Transform(({ value }) => parseInt(value, 10))
  @IsNumber()
  exp: number;
}
