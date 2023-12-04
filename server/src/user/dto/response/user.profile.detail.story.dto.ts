import { ApiProperty } from '@nestjs/swagger';

export class UserProfileDetailStoryDto {
  @ApiProperty()
  storyId: number;

  @ApiProperty()
  thumbnailImageURL: string;

  @ApiProperty()
  title: string;

  @ApiProperty()
  content: string;

  @ApiProperty()
  likeState: number;

  @ApiProperty()
  likeCount: number;

  @ApiProperty()
  commentCount: number;
}

export class UserProfileDetailStoryJsonDto {
  @ApiProperty({ description: '유저의 디테일한 스토리 정보를 리턴', type: UserProfileDetailStoryDto, isArray: true })
  stories: UserProfileDetailStoryDto[];
}
