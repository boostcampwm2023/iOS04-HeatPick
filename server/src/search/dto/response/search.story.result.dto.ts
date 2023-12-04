import { ApiProperty } from '@nestjs/swagger';
import { StoryResultDto } from './story.result.dto';

export class SearchStoryResultDto {
  @ApiProperty({ description: '스토리 배열', type: StoryResultDto, isArray: true })
  stories: StoryResultDto[];

  @ApiProperty({ description: '마지막 페이지인지를 리턴', type: Boolean })
  isLastPage: boolean;
}
