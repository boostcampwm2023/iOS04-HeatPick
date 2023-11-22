import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Transform, Type } from 'class-transformer';

@Entity()
export class Badge {
  @PrimaryGeneratedColumn()
  badgeId: number;

  @Column()
  badgeName: string;

  @Column()
  @Transform(({ value }) => parseInt(value, 10))
  badgeExp: number;

  @Column()
  emoji: string;

  @ManyToOne(() => User, (user) => user.badges)
  user: User;
}
