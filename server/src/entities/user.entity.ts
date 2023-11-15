import { Column, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';
import { profileImage } from './profileImage.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  userId: number;

  @OneToMany(() => Story, (story) => story.user, {
    cascade: true,
  })
  stories: Promise<Story[]>;

  @Column({ unique: true })
  username: string;

  @Column({ unique: true })
  oauthId: string;

  @OneToOne(() => profileImage, {
    cascade: true,
  })
  @JoinColumn()
  profileImage: profileImage;

  @Column()
  temperature: number;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  recentActive: Date;
}
