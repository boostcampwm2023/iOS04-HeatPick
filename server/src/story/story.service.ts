import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { UserRepository } from './../user/user.repository';
import { ImageService } from '../image/image.service';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { createStoryEntity } from '../util/util.create.story.entity';
import { Cron, CronExpression } from '@nestjs/schedule';
import { MoreThan } from 'typeorm';
import { LocationDTO } from 'src/place/dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
import { JwtService } from '@nestjs/jwt';
import { User } from '../entities/user.entity';
import { StoryDetailViewDataDto } from './dto/detail/story.detail.view.data.dto';
import { StoryDetailPlaceDataDto } from './dto/detail/story.detail.place.data.dto';
import { StoryDetailStoryDataDto } from './dto/detail/story.detail.story.data';
import { StoryImage } from '../entities/storyImage.entity';
import { StoryDetailUserDataDto } from './dto/detail/story.detail.user.data';
import { Badge } from '../entities/badge.entity';
import { Place } from '../entities/place.entity';
import { storyEntityToObjWithOneImg } from 'src/util/story.entity.to.obj';
import { CategoryRepository } from '../category/category.repository';
import { CreateStoryMetaDto } from './dto/story.create.meta.dto';
import { Category } from '../entities/category.entity';
import { UserService } from 'src/user/user.service';

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
    private storyTitleJasoTrie: StoryJasoTrie,
    private categoryRepository: CategoryRepository,
    private userService: UserService,
  ) {
    this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    this.storyRepository.loadEveryStory().then((everyStory) => {
      everyStory.forEach((story) => this.storyTitleJasoTrie.insert(graphemeSeperation(story.title), story.storyId));
    });
  }

  public async createMetaData(userId: string) {
    const user: User = await this.userRepository.findOneByIdWithBadges(userId);
    const categoryList = await this.categoryRepository.finAll();
    const metaData: CreateStoryMetaDto = {
      badges: (await user.badges).map((badge: Badge) => {
        return { badgeId: badge.badgeId, badgeName: badge.badgeName };
      }),
      categories: categoryList,
    };
    return metaData;
  }

  public async create(userId: string, { title, content, categoryId, place, images, badgeId, date }): Promise<number> {
    const user: User = await this.userRepository.findOneByIdWithBadges(userId);
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const category: Category = await this.categoryRepository.findById(categoryId);
    const story: Story = await createStoryEntity({ title, content, category, place, images, badge, date });
    user.stories = Promise.resolve([...(await user.stories), story]);
    await this.userRepository.createUser(user);
    if (badge) this.userService.addBadgeExp({ badgeName: badge.badgeName, userId: user.userId, exp: 10 });
    return story.storyId;
  }

  public async read(userId: string, storyId: number) {
    const story: Story = await this.storyRepository.findById(storyId);
    const place: Place = await story.place;

    const storyDetailPlaceData: StoryDetailPlaceDataDto = {
      title: place.title,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
    };
    console.log(story);
    const storyDetailStoryData: StoryDetailStoryDataDto = {
      storyId: story.storyId,
      createdAt: story.createAt,
      category: story.category.categoryName,
      storyImageURL: (await story.storyImages).map((storyImage: StoryImage) => storyImage.imageUrl),
      title: story.title,
      badgeName: `${story.badge?.emoji}${story.badge?.badgeName}`,
      likeCount: story.likeCount,
      commentCount: story.commentCount,
      content: story.content,
      place: storyDetailPlaceData,
    };

    const storyDetailUserData: StoryDetailUserDataDto = {
      userId: story.user.userId,
      username: story.user.username,
      profileImageUrl: story.user.profileImage.imageUrl,
      status: userId === story.user.oauthId ? 0 : 1,
    };

    const storyDetailViewData: StoryDetailViewDataDto = {
      story: storyDetailStoryData,
      author: storyDetailUserData,
    };

    return storyDetailViewData;
  }

  public async update(userId: string, { storyId, title, content, categoryId, place, images, badgeId, date }): Promise<number> {
    const user: User = await this.userRepository.findOneById(userId);
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const category: Category = await this.categoryRepository.findById(categoryId);
    const newStory: Story = await createStoryEntity({ title, content, category, place, images, badge, date });

    user.stories = Promise.resolve(
      (await user.stories).map((story: Story): Story => {
        if (story.storyId === storyId) return newStory;
        return story;
      }),
    );
    await this.userRepository.createUser(user);
    return newStory.storyId;
  }

  public async delete(userId: string, storyId: number) {
    const user: User = await this.userRepository.findOneById(userId);
    user.stories = Promise.resolve((await user.stories).filter((story) => story.storyId !== storyId));
    await this.userRepository.createUser(user);
  }

  async getStoriesFromTrie(seperatedStatement: string[], limit: number) {
    const ids = this.storyTitleJasoTrie.search(seperatedStatement, limit);
    const stories = await this.storyRepository.getStoriesByIds(ids);
    return stories;
  }

  async getRecommendByLocationStory(locationDto: LocationDTO) {
    const stories = await this.storyRepository.getStoryByCondition({ where: { likeCount: MoreThan(10) }, take: 10, relations: ['user', 'category'] });

    const userLatitude = locationDto.latitude;
    const userLongitude = locationDto.longitude;

    const radius = 2;

    const results = await Promise.all(
      stories.map(async (story) => {
        const place = await story.place;

        if (place) {
          const placeDistance = calculateDistance(userLatitude, userLongitude, place.latitude, place.longitude);
          return placeDistance <= radius ? story : null;
        }
        return null;
      }),
    );
    const storyArr = await Promise.all(
      results.map(async (story) => {
        return storyEntityToObjWithOneImg(story);
      }),
    );
    return storyArr.filter((result) => result !== null);
  }

  async getRecommendedStory() {
    try {
      const stories = await this.storyRepository.getStoryByCondition({
        order: {
          likeCount: 'DESC',
        },
        take: 10,
        relations: ['user', 'user.profileImage', 'storyImages', 'category'],
      });

      const storyArr = await Promise.all(
        stories.map(async (story) => {
          return storyEntityToObjWithOneImg(story);
        }),
      );

      return storyArr;
    } catch (error) {
      throw error;
    }
  }
}
