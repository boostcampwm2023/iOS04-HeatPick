import { Column, Entity, ManyToOne, PrimaryGeneratedColumn, ManyToMany, JoinTable, OneToMany } from 'typeorm';
import { User } from './user.entity';
import { Category } from './category.entity';
import { StoryImage } from './storyImage.entity';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Story {
  @PrimaryGeneratedColumn()
  @ApiProperty({ description: 'story id' })
  storyId: number;

  @ManyToOne(() => User, (user) => user.stories)
  user: User;

  @Column()
  @ApiProperty({ description: 'Story의 제목' })
  title: string;

  @Column('text')
  @ApiProperty({ description: 'Story의 내용' })
  content: string;

  @OneToMany(() => StoryImage, (storyImage) => storyImage.story, { cascade: true })
  @ApiProperty({ description: 'Story에 포함된 이미지' })
  storyImages: Promise<StoryImage[]>;

  @Column()
  @ApiProperty({ description: 'Story의 좋아요 수' })
  likeCount: number;

  @Column()
  @ApiProperty({ description: 'Story가 작성된 날짜' })
  createAt: Date;

  @ManyToMany(() => Category, {
    cascade: true,
  })
  @JoinTable()
  categories: Promise<Category[]>;
}
