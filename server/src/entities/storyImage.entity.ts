import { Column, Entity, JoinTable, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class StoryImage {
  @PrimaryGeneratedColumn()
  imageId: number;

  @Column()
  imageUrl: string;

  @ManyToOne(() => Story)
  @JoinTable()
  story: Story;
}
