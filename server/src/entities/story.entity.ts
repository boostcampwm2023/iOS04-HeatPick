import { Column, Entity, ManyToOne, PrimaryGeneratedColumn, ManyToMany, JoinTable, OneToMany, OneToOne, JoinColumn, DeleteDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Category } from './category.entity';
import { StoryImage } from './storyImage.entity';
import { Place } from './place.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Comment } from './comment.entity';
import { Badge } from './badge.entity';
@Entity()
export class Story {
  @PrimaryGeneratedColumn()
  @ApiProperty({ description: 'story id' })
  storyId: number;

  @ManyToOne(() => User, (user) => user.stories)
  user: Promise<User>;

  @Column()
  @ApiProperty({ description: 'Story의 제목' })
  title: string;

  @Column('text')
  @ApiProperty({ description: 'Story의 내용' })
  content: string;

  @OneToMany(() => StoryImage, (storyImage) => storyImage.story, { cascade: true })
  @ApiProperty({ description: 'Story에 포함된 이미지' })
  storyImages: Promise<StoryImage[]>;

  @Column({ default: 0 })
  @ApiProperty({ description: 'Story의 좋아요 수' })
  likeCount: number;

  @Column({ default: 0 })
  @ApiProperty({ description: 'Story의 댓글 수' })
  commentCount: number;

  @Column()
  @ApiProperty({ description: 'Story가 작성된 날짜' })
  createAt: Date;

  @ManyToOne(() => Category, (category: Category) => category.stories, {
    cascade: true,
  })
  @JoinColumn()
  category: Category;

  @ManyToOne(() => Badge, (badge: Badge) => badge.stories, {
    cascade: true,
  })
  @JoinColumn()
  badge: Badge;

  @OneToOne(() => Place, (place) => place.story, { cascade: true })
  @JoinColumn()
  place: Promise<Place>;

  @OneToMany(() => Comment, (comment) => comment.story, { cascade: true })
  comments: Promise<Comment[]>;

  @ManyToMany(() => User, (user) => user.likedStories, { cascade: true })
  @JoinTable({
    name: 'story_liked_user',
    joinColumn: {
      name: 'storyId',
      referencedColumnName: 'storyId',
    },
    inverseJoinColumn: {
      name: 'userId',
      referencedColumnName: 'userId',
    },
  })
  usersWhoLiked: Promise<User[]>;

  @DeleteDateColumn({ nullable: true, default: null })
  deletedAt: Date;
}
