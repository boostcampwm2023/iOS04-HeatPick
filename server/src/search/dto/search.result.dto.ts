import { ApiProperty } from '@nestjs/swagger';
import { Story } from 'src/entities/story.entity';
import { User } from 'src/entities/user.entity';

export class SearchResultDto {
  @ApiProperty({ description: '스토리 객체의 배열' })
  stories: Story[];

  @ApiProperty({ description: '유저 객체의 배열' })
  users: User[];
}
