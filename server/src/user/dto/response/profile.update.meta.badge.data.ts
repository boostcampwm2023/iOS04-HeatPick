import { ApiProperty } from '@nestjs/swagger';

export class ProfileUpdateMetaBadgeData {
  @ApiProperty()
  badgeId: number;

  @ApiProperty()
  badgeName: string;

  @ApiProperty()
  badgeExp: number;

  @ApiProperty()
  emoji: string;

  @ApiProperty()
  badgeExplain: string;
}
