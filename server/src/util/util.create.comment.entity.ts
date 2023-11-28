import { Comment } from '../entities/comment.entity';
import { User } from '../entities/user.entity';

export const createCommentEntity = (content: string, user: User, mentionedUsers: User[]) => {
  const comment = new Comment();
  comment.user = user;
  comment.content = content;
  comment.mentions = [...mentionedUsers];

  return comment;
};
