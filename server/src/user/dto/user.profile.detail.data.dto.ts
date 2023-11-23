import { Badge } from '../../entities/badge.entity';
import { Story } from '../../entities/story.entity';
import { ApiProperty } from '@nestjs/swagger';

export class UserProfileDetailDataDto {
  @ApiProperty()
  username: string;

  @ApiProperty()
  profileURL: string;

  @ApiProperty()
  followerCount: number;

  @ApiProperty()
  storyCount: number;

  @ApiProperty()
  experience: number;

  @ApiProperty()
  maxExperience: number;

  @ApiProperty()
  mainBadge: Badge;

  @ApiProperty()
  storyList: Story[];
}
