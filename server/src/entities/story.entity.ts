import { Column, Entity, ManyToOne, PrimaryGeneratedColumn, ManyToMany, JoinTable, OneToMany, OneToOne } from 'typeorm';
import { User } from './user.entity';
import { Category } from './category.entity';
import { StoryImage } from './storyImage.entity';
import { Place } from './place.entity';

@Entity()
export class Story {
  @PrimaryGeneratedColumn()
  storyId: number;

  @ManyToOne(() => User, (user) => user.stories)
  user: User;

  @Column()
  title: string;

  @Column('text')
  content: string;

  @OneToMany(() => StoryImage, (storyImage) => storyImage.story, { cascade: true })
  storyImages: Promise<StoryImage[]>;

  @Column()
  likeCount: number;

  @Column()
  createAt: Date;

  @ManyToMany(() => Category, {
    cascade: true,
  })
  @JoinTable()
  categories: Promise<Category[]>;

  @OneToOne(() => Place, { cascade: true })
  place: Promise<Place>;
}
