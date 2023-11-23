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

@Injectable()
export class StoryService {
  constructor(
    private storyRepository: StoryRepository,
    private userRepository: UserRepository,
    private imageService: ImageService,
    private storyTitleJasoTrie: StoryJasoTrie,
    private jwtService: JwtService,
  ) {
    this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    this.storyRepository.loadEveryStory().then((everyStory) => {
      everyStory.forEach((story) => this.storyTitleJasoTrie.insert(graphemeSeperation(story.title), story.storyId));
    });
  }

  public async create(accessToken: string, { title, content, category, place, images, badgeId, date }): Promise<number> {
    const decodedToken = this.jwtService.decode(accessToken);
    const userId = decodedToken.userId;
    const user: User = await this.userRepository.findOneByIdWithBadges(userId);
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const story: Story = await createStoryEntity({ title, content, category, place, images, badge, date });
    user.stories = Promise.resolve([...(await user.stories), story]);
    await this.userRepository.createUser(user);
    return story.storyId;
  }

  public async read(accessToken: string, storyId: number) {
    const story: Story = await this.storyRepository.findById(storyId);
    const place: Place = await story.place;

    const storyDetailPlaceData: StoryDetailPlaceDataDto = {
      title: place.title,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
    };

    const storyDetailStoryData: StoryDetailStoryDataDto = {
      createdAt: story.createAt,
      category: story.category.categoryName,
      storyImageURL: (await story.storyImages).map((storyImage: StoryImage) => storyImage.imageUrl),
      title: story.title,
      badgeName: `${story.badge.emoji}${story.badge.badgeName}`,
      likeCount: story.likeCount,
      commentCount: story.commentCount,
      content: story.content,
      place: storyDetailPlaceData,
    };

    const storyDetailUserData: StoryDetailUserDataDto = {
      userId: story.user.userId,
      username: story.user.username,
      profileImageUrl: story.user.profileImage.imageUrl,
      status: this.jwtService.decode(accessToken).userId === story.user.oauthId ? 0 : 1,
    };

    const storyDetailViewData: StoryDetailViewDataDto = {
      story: storyDetailStoryData,
      author: storyDetailUserData,
    };

    return storyDetailViewData;
  }

  public async update(accessToken: string, { storyId, title, content, category, place, images, badgeId, date }): Promise<number> {
    const decodedToken = this.jwtService.decode(accessToken);
    const userId = decodedToken.userId;
    const user: User = await this.userRepository.findOneById(userId);
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
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

  public async delete(accessToken: string, storyId: number) {
    const decodedToken = this.jwtService.decode(accessToken);
    const userId = decodedToken.userId;
    const user: User = await this.userRepository.findOneById(userId);
    user.stories = Promise.resolve((await user.stories).filter((story) => story.storyId !== storyId));
    await this.userRepository.createUser(user);
  }

  async getStoriesFromTrie(seperatedStatement: string[]) {
    const ids = this.storyTitleJasoTrie.search(seperatedStatement);
    const stories = await this.storyRepository.getStoriesByIds(ids);
    return stories;
  }

  async getRecommendByLocationStory(locationDto: LocationDTO) {
    const stories = await this.storyRepository.getStoryByCondition({ where: { likeCount: MoreThan(10) }, take: 10, relations: ['user'] });

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

    return results.filter((result) => result !== null);
  }

  async getRecommendedStory() {
    try {
      const stories = await this.storyRepository.getStoryByCondition({
        order: {
          likeCount: 'DESC',
        },
        take: 10,
        relations: ['user', 'user.profileImage', 'storyImages'],
        select: ['storyId', 'title', 'likeCount', 'createAt', 'user.userId', 'user.username', 'user.profileImage'],
      });

      const formattedStories = Promise.all(
        stories.map(async (story) => {
          const storyImageObjs = await story.storyImages;
          return {
            storyId: story.storyId,
            title: story.title,
            likeCount: story.likeCount,
            createAt: story.createAt,
            user: story.user,
            storyImages: storyImageObjs.map((image) => image.imageUrl),
          };
        }),
      );

      return formattedStories;
    } catch (error) {
      throw error;
    }
  }
}
