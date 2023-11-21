import { Comment } from '../entities/comment.entity';

export const createCommentEntity = (content: string) => {
  const comment = new Comment();
  comment.content = content;

  return comment;
};
