import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { User } from './user.entity';
import { Transform } from 'class-transformer';
import { Story } from './story.entity';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Badge {
  @PrimaryGeneratedColumn()
  @ApiProperty({ description: 'badge의 Id' })
  badgeId: number;

  @Column()
  @ApiProperty({ description: 'badge의 이름' })
  badgeName: string;

  @Column({ default: 0 })
  @Transform(({ value }) => parseInt(value, 10))
  @ApiProperty({ description: 'badge의 경험치' })
  badgeExp: number;

  @Column()
  @ApiProperty({ description: 'badge에 매칭되는 이모지' })
  emoji: string;

  @ManyToOne(() => User, (user) => user.badges)
  user: User;

  @OneToOne(() => User, (user) => user.representativeBadge)
  @JoinColumn()
  representativeUser: User;

  @OneToMany(() => Story, (story: Story) => story.badge)
  stories: Story[];
}
