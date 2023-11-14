import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  userId: number;

  @OneToMany(() => Story, (story) => story.user)
  stories: Story[];

  @Column({ unique: true })
  username: string;

  @Column({ unique: true })
  oauthId: string;

  @Column()
  profileImageURL: string;

  @Column()
  temperature: number;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  createAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  recentActive: Date;
}
