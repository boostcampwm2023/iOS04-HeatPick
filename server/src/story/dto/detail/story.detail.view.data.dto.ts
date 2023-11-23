import { ApiProperty } from '@nestjs/swagger';
import { StoryDetailUserDataDto } from './story.detail.user.data';
import { StoryDetailStoryDataDto } from './story.detail.story.data';

export class StoryDetailViewDataDto {
  @ApiProperty()
  story: StoryDetailStoryDataDto;

  @ApiProperty()
  author: StoryDetailUserDataDto;
}
