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

  @Column({ type: 'float' })
  latitude: number;

  @Column({ type: 'float' })
  longitude: number;

  @OneToOne(() => Story, (story) => story.place)
  story: Promise<Story>;
}
