import { Badge } from '../../../entities/badge.entity';
import { ApiProperty } from '@nestjs/swagger';
import { UserProfileDetailStoryDto } from './user.profile.detail.story.dto';

export class UserProfileDetailDataDto {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  username: string;

  @ApiProperty()
  profileURL: string;

  @ApiProperty()
  isFollow: number;

  @ApiProperty()
  followerCount: number;

  @ApiProperty()
  storyCount: number;

  @ApiProperty()
  temperature: number;

  @ApiProperty()
  temperatureFeeling: string;

  @ApiProperty()
  experience: number;

  @ApiProperty()
  maxExperience: number;

  @ApiProperty()
  mainBadge: Badge;

  @ApiProperty()
  badgeExplain: string;

  @ApiProperty({ type: () => UserProfileDetailStoryDto })
  storyList: UserProfileDetailStoryDto[];
}

export class UserProfileDetailJsonDto {
  @ApiProperty({ description: '유저 프로필 정보를 JSON 형태로 리턴.', type: UserProfileDetailDataDto })
  profile: UserProfileDetailDataDto;
}