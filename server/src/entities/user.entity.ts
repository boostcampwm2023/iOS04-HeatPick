import { Column, DeleteDateColumn, Entity, JoinColumn, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Story } from './story.entity';
import { profileImage } from './profileImage.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Comment } from './comment.entity';
import { Badge } from './badge.entity';
@Entity()
export class User {
  @PrimaryGeneratedColumn()
  @ApiProperty({ description: 'User Column을 식별하기 위한 userId' })
  userId: number;

  @OneToMany(() => Story, (story) => story.user, {
    cascade: true,
  })
  stories: Promise<Story[]>;

  @Column({ unique: true })
  @ApiProperty({ description: 'User의 nickname' })
  username: string;

  @Column({ unique: true })
  @ApiProperty({ description: 'User가 로그인 시 사용했던 OAuth Token을 사용하여 얻어온 Id' })
  oauthId: string;

  @OneToOne(() => profileImage, {
    cascade: true,
  })
  @JoinColumn()
  profileImage: profileImage;

  @Column()
  @ApiProperty({ description: 'User의 온도(레벨)' })
  temperature: number;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  @ApiProperty({ description: 'User의 회원 가입 시간' })
  createAt: Date;

  @DeleteDateColumn({ name: 'deletedAt' }) // Soft Delete를 위한 삭제 날짜 칼럼 추가
  @ApiProperty({ description: 'User의 회원 탈퇴 시간' })
  deletedAt: Date;

  @Column({ default: () => 'CURRENT_TIMESTAMP' })
  @ApiProperty({ description: 'User의 최근 활동 시간' })
  recentActive: Date;

  @OneToMany(() => Comment, (comment) => comment.user)
  comments: Comment;

  @OneToMany(() => Badge, (badge) => badge.user, { cascade: true })
  badges: Promise<Badge[]>;
}
