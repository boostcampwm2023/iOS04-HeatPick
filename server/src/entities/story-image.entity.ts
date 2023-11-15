import {
  Column,
  Entity,
  JoinTable,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class story_image {
  @PrimaryGeneratedColumn()
  image_id: number;

  @Column()
  image_url: string;

  @ManyToOne(() => Story)
  @JoinTable()
  story: Story;
}
