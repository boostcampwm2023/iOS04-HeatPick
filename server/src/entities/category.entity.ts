import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class Category {
  @PrimaryGeneratedColumn()
  categoryId: number;

  @Column()
  categoryName: string;

}
