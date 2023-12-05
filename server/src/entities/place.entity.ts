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

  @Column('decimal', { precision: 30, scale: 20 })
  latitude: number;

  @Column('decimal', { precision: 30, scale: 20 })
  longitude: number;

  @OneToOne(() => Story, (story) => story.place)
  story: Promise<Story>;
}
