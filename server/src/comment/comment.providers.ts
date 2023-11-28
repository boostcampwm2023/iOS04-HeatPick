import { DataSource } from 'typeorm';
import { Comment } from '../entities/comment.entity';

export const CommentProviders = [
  {
    provide: 'COMMENT_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Comment),
    inject: ['DATA_SOURCE'],
  },
];
