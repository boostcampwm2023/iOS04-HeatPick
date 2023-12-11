import { Column, DeleteDateColumn, Entity, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
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

  @ManyToMany(() => User, (user) => user.mentions, { cascade: true })
  @JoinTable({
    name: 'user_mention_comment',
    joinColumn: {
      name: 'commentId',
      referencedColumnName: 'commentId',
    },
    inverseJoinColumn: {
      name: 'userId',
      referencedColumnName: 'userId',
    },
  })
  mentions: User[];

  @Column()
  createdAt: Date;

  @DeleteDateColumn({ nullable: true, default: null })
  deletedAt: Date;
}
