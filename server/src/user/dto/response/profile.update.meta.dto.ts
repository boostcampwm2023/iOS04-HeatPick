import { ApiProperty } from '@nestjs/swagger';
import { ProfileUpdateMetaBadgeData } from './profile.update.meta.badge.data';

export class ProfileUpdateMetaDataDto {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  profileImageURL: string;

  @ApiProperty()
  username: string;

  @ApiProperty({ type: () => ProfileUpdateMetaBadgeData })
  badges: ProfileUpdateMetaBadgeData;
}
