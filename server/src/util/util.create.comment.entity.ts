import { Comment } from '../entities/comment.entity';
import { User } from '../entities/user.entity';
import { Story } from '../entities/story.entity';

export const createCommentEntity = (content: string, user: User, story: Story) => {
  const comment = new Comment();
  comment.user = user;
  comment.content = content;
  comment.createdAt = new Date();
  comment.story = story;

  return comment;
};
