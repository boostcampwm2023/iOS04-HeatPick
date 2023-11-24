import { ApiProperty } from '@nestjs/swagger';
import { StoryResultDto } from './story.result.dto';
import { UserResultDto } from './user.result.dto';

export class SearchResultDto {
  @ApiProperty({ description: '스토리 객체의 배열' })
  stories: StoryResultDto[];

  @ApiProperty({ description: '유저 객체의 배열' })
  users: UserResultDto[];
}
