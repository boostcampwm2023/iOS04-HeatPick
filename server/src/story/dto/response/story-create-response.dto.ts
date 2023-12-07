import { ApiProperty } from '@nestjs/swagger';

export class StoryCreateBadgeResponseDto {
  @ApiProperty({ description: `뱃지 이모지` })
  badgeEmoji: string;

  @ApiProperty({ description: `변화된 뱃지 정보` })
  badgeName: string;
  @ApiProperty({ description: `이전 경험치` })
  prevExp: number;
  @ApiProperty({ description: `현재 경험치` })
  nowExp: number;
}

export class StoryCreateResponseDto {
  @ApiProperty({ description: '유저 아이디' })
  storyId: number;

  @ApiProperty({ description: `변화된 뱃지 정보`, type: StoryCreateBadgeResponseDto })
  badge: StoryCreateBadgeResponseDto;
}
