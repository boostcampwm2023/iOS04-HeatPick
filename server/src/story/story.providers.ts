import { Story } from 'src/entities/story.entity';
import { DataSource } from 'typeorm';

export const storyProvider = [
  {
    provide: 'STORY_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Story),
    inject: ['DATA_SOURCE'],
  },
];
