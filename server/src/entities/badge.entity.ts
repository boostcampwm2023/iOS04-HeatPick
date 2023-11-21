import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';

@Entity()
export class Badge {
  @PrimaryGeneratedColumn()
  badgeId: number;

  @Column()
  badgeName: string;

  @Column()
  badgeExp: number;

  @Column()
  emoji: string;

  @ManyToOne(() => User, (user) => user.badges)
  user: User;
}
