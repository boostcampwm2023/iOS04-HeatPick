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
