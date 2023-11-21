import { Badge } from '../../entities/badge.entity';
import { Story } from '../../entities/story.entity';

export type userProfileDetailDataType = {
  username: string;
  profileURL: string;
  followerCount: number;
  storyCount: number;
  experience: number;
  maxExperience: number;
  badge: Badge[];
  storyList: Story[];
};
