import { ApiProperty } from '@nestjs/swagger';
import { StoryDetailStoryDataResponseDto } from './story.detail.story.data.response';
import { StoryDetailUserDataResponseDto } from './story.detail.user.data.response';

export class StoryDetailViewDataResponseJSONDto {
  @ApiProperty()
  story: StoryDetailStoryDataResponseDto;

  @ApiProperty()
  author: StoryDetailUserDataResponseDto;
}

export const getStoryDetailViewDataResponseJSONDto = (storyDto: StoryDetailStoryDataResponseDto, authorDto: StoryDetailUserDataResponseDto): StoryDetailViewDataResponseJSONDto => {
  return {
    story: storyDto,
    author: authorDto,
  };
};
