import { Story } from '../../entities/story.entity';
import { userDataInStoryView } from './story.user.data';

export type StoryDetailViewData = {
  story: Story;
  //isFollowed: boolean;
  //recommendStoryList: Story[];
  author: userDataInStoryView;
};
