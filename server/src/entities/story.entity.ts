import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Category } from './category.entity';
import { JoinColumn } from 'typeorm/browser';

@Entity()
export class Story {
  @PrimaryGeneratedColumn()
  storyId: number;

  @ManyToOne(() => User, (user) => user.stories)
  user: User;

  @Column()
  title: string;

  @Column('text')
  content: string;

  @Column()
  storyImageURL: string;

  @Column()
  likeCount: number;

  @Column()
  createAt: Date;

  @Column(() => Category)
  @JoinColumn()
  category: Category;
}
