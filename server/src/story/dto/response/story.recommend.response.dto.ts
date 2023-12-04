import { ApiProperty } from '@nestjs/swagger';
import { Story } from 'src/entities/story.entity';

export class RecommendStoryDto {
  @ApiProperty({ description: '스토리 리스트' })
  recommendStories: Story;
}
