import { ApiProperty } from '@nestjs/swagger';

export class AddBadgeDto {
  @ApiProperty({ description: '뱃지의 이름입니다.' })
  badgeName: string;

  @ApiProperty({ description: '유저의 고유 ID입니다.' })
  userId: number;
}
