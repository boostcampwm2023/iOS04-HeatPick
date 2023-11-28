import { ApiProperty } from '@nestjs/swagger';
import { StoryResultDto } from './story.result.dto';

export class SearchStoryResultDto {
  @ApiProperty({ description: '스토리 배열', type: StoryResultDto, isArray: true })
  stories: StoryResultDto[];
}
