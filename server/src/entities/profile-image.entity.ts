import {
  Column,
  Entity,
  JoinTable,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './user.entity';

@Entity()
export class story_image {
  @PrimaryGeneratedColumn()
  image_id: number;

  @Column()
  image_url: string;

  @OneToOne(() => User)
  @JoinTable()
  user: User;
}
