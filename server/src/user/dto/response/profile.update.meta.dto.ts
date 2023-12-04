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
  nowBadge: ProfileUpdateMetaBadgeData;

  @ApiProperty({ type: () => ProfileUpdateMetaBadgeData })
  badges: ProfileUpdateMetaBadgeData[];
}

export class ProfileUpdateMetaDataJsonDto {
  @ApiProperty({ description: 'profile 상세 정보 Json 데이터', type: ProfileUpdateMetaDataDto })
  profile: ProfileUpdateMetaDataDto;
}
