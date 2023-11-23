import { ApiProperty } from '@nestjs/swagger';
import { StoryDetailPlaceDataDto } from './story.detail.place.data.dto';

export class StoryDetailStoryDataDto {
  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  category: string;

  @ApiProperty()
  storyImageURL: string[];

  @ApiProperty()
  title: string;

  @ApiProperty()
  BadgeId: number;

  @ApiProperty()
  likeCount: number;

  @ApiProperty()
  commentCount: number;

  @ApiProperty()
  content: string;

  @ApiProperty()
  place: StoryDetailPlaceDataDto;
}
