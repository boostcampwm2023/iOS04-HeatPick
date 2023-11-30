import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
@Entity()
export class profileImage {
  @PrimaryGeneratedColumn()
  imageId: number;

  @Column()
  imageUrl: string;
}
