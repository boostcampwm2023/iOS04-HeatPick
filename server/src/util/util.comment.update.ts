import { Comment } from '../entities/comment.entity';

export const updateComment = (comment: Comment, { content }) => {
  comment.content = content;

  return comment;
};
