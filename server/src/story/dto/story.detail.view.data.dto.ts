import { Story } from '../../entities/story.entity';
import { ApiProperty } from '@nestjs/swagger';
import { userDataInStoryView } from './story.detail.user.data';

export class StoryDetailViewData {
  @ApiProperty()
  story: Story;

  //isFollowed: boolean;
  //recommendStoryList: Story[];

  @ApiProperty()
  author: userDataInStoryView;
}
