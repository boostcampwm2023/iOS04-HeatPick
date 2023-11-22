import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsString } from 'class-validator';

export class AddBadgeDto {
  @ApiProperty({ description: '뱃지의 이름입니다.' })
  @IsString()
  badgeName: string;

  @ApiProperty({ description: '유저의 고유 ID입니다.' })
  @IsNumber()
  userId: number;
}
