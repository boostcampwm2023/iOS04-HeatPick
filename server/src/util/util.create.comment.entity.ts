import { Comment } from '../entities/comment.entity';
import { User } from '../entities/user.entity';

export const createCommentEntity = (content: string, mentionedUsers: User[]) => {
  const comment = new Comment();
  comment.content = content;
  comment.mentions = [...mentionedUsers];

  return comment;
};
