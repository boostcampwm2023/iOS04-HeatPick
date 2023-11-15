import { Column, Entity, JoinTable, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';

@Entity()
export class profileImage {
  @PrimaryGeneratedColumn()
  imageId: number;

  @Column()
  imageUrl: string;
}
