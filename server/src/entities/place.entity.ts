import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class Place {
  @PrimaryGeneratedColumn()
  placeId: number;

  @Column()
  title: string;

  @Column()
  address: string;

  @Column('double', { precision: 20, scale: 16 })
  latitude: number;

  @Column('double', { precision: 20, scale: 16 })
  longitude: number;

  @OneToOne(() => Story, (story) => story.place)
  story: Promise<Story>;
}
