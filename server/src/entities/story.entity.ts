import { Column, Entity, ManyToOne, PrimaryGeneratedColumn, ManyToMany, JoinTable } from 'typeorm';
import { User } from './user.entity';
import { Category } from './category.entity';

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

  @ManyToMany(() => Category, {
    cascade: true,
  })
  @JoinTable()
  categories: Promise<Category[]>;
}
