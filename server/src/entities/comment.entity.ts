import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';
import { User } from './user.entity';

@Entity()
export class Comment {
  @PrimaryGeneratedColumn()
  commentId: number;

  @ManyToOne(() => User, (user) => user.comments)
  user: User;

  @ManyToOne(() => Story, (story) => story.comments)
  story: Story;

  @Column()
  content: string;
}
