import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class SearchHistory {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  content: string;

  @Column()
  count: number;
}
