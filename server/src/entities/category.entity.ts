import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class Category {
  @PrimaryGeneratedColumn()
  categoryId: number;

  @Column()
  categoryName: string;

  @OneToMany(() => Story, (story: Story) => story.category)
  stories: Story[];
}
