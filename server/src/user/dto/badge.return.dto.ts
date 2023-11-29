import { ApiProperty } from '@nestjs/swagger';

export class BadgeReturnDto {
  @ApiProperty({ description: '뱃지의 아이디입니다.' })
  badgeId: number;

  @ApiProperty({ description: '뱃지의 이름입니다.' })
  badgeName: string;

  @ApiProperty({ description: '뱃지의 이모지입니다.' })
  emoji: string;

  @ApiProperty({ description: '뱃지의 설명입니다.' })
  description: string;
}

export class BadgeJsonDto {
  @ApiProperty({ description: '뱃지 정보를 담은 배열.', isArray: true })
  badges: BadgeReturnDto[];
}
