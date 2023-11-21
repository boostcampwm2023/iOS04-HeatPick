import { Injectable } from '@nestjs/common';
import { StoryRepository } from './story.repository';
import { Story } from '../entities/story.entity';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { userDataInStoryView } from './type/story.user.data';
import { UserRepository } from './../user/user.repository';
import { ImageService } from '../image/image.service';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { createStoryEntity } from '../util/util.create.story.entity';
import { Cron, CronExpression } from '@nestjs/schedule';
import { FindManyOptions, MoreThan } from 'typeorm';
import { LocationDTO } from 'src/place/dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
import { Place } from 'src/entities/place.entity';
import { JwtService } from '@nestjs/jwt';
import { User } from '../entities/user.entity';

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

  public async create(accessToken: string, { title, content, category, place, images, date }): Promise<number> {
    const story: Story = await createStoryEntity({ title, content, category, place, images, date });
    const decodedToken = this.jwtService.verify(accessToken);
    const userId = decodedToken.userId;
    const user: User = await this.userRepository.findOneById(userId);
    user.stories = Promise.resolve([...(await user.stories), story]);
    await this.userRepository.createUser(user);
    return story.storyId;
  }

  public async read(storyId: number): Promise<StoryDetailViewData> {
    const story: Story = await this.storyRepository.findById(storyId);
    const user: User = story.user;
    delete story.user;

    const userData: userDataInStoryView = {
      userId: user.userId,
      username: user.username,
      storyImageURL: (await story.storyImages).map((storyImage) => storyImage.imageUrl),
      //badge: story.user.badge
    };

    return {
      story: story,
      author: userData,
    };
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
        relations: ['user'],
      });
      return stories;
    } catch (error) {
      throw error;
    }
  }

  public async update(accessToken: string, { storyId, title, content, category, place, images, date }): Promise<number> {
    const newStory = await createStoryEntity({ title, content, category, place, images, date });
    const decodedToken = this.jwtService.verify(accessToken);
    const userId = decodedToken.userId;
    const user = await this.userRepository.findOneById(userId);

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
    const decodedToken = this.jwtService.verify(accessToken);
    const userId = decodedToken.userId;
    const user: User = await this.userRepository.findOneById(userId);
    user.stories = Promise.resolve((await user.stories).filter((story) => story.storyId !== storyId));
    await this.userRepository.createUser(user);
  }
}
