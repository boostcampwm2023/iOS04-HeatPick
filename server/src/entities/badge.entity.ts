import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Transform } from 'class-transformer';
import { Story } from './story.entity';

@Entity()
export class Badge {
  @PrimaryGeneratedColumn()
  badgeId: number;

  @Column()
  badgeName: string;

  @Column({ default: 0 })
  @Transform(({ value }) => parseInt(value, 10))
  badgeExp: number;

  @Column()
  emoji: string;

  @ManyToOne(() => User, (user) => user.badges)
  user: User;

  @OneToOne(() => User)
  @JoinColumn()
  representativeUser: User;

  @OneToMany(() => Story, (story: Story) => story.badge)
  stories: Story[];
}
