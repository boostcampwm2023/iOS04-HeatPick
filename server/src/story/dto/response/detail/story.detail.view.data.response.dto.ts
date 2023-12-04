import { ApiProperty } from '@nestjs/swagger';
import { StoryDetailStoryDataResponseDto } from './story.detail.story.data.response';
import { StoryDetailUserDataResponseDto } from './story.detail.user.data.response';

export class StoryDetailViewDataResponseDto {
  @ApiProperty()
  story: StoryDetailStoryDataResponseDto;

  @ApiProperty()
  author: StoryDetailUserDataResponseDto;
}

export const getStoryDetailViewDataResponseDto = (storyDto: StoryDetailStoryDataResponseDto, authorDto: StoryDetailUserDataResponseDto): StoryDetailViewDataResponseDto => {
  return {
    story: storyDto,
    author: authorDto,
  };
};
