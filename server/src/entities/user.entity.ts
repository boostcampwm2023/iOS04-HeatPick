import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  userId: number;

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
