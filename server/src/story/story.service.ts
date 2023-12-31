import { forwardRef, Inject, Injectable } from '@nestjs/common';
import { Story } from '../entities/story.entity';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { createStoryEntity } from '../util/util.create.story.entity';
import { Cron, CronExpression } from '@nestjs/schedule';
import { LocationDTO } from 'src/place/dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
import { User } from '../entities/user.entity';
import { getStoryDetailPlaceDataResponseDto, StoryDetailPlaceDataResponseDto } from './dto/response/detail/story.detail.place.data.response.dto';
import { Badge } from '../entities/badge.entity';
import { Place } from '../entities/place.entity';
import { storyEntityToObjWithOneImg } from 'src/util/story.entity.to.obj';
import { Category } from '../entities/category.entity';
import { UserService } from 'src/user/user.service';
import { updateStory } from '../util/util.story.update';
import { In, Repository } from 'typeorm';
import { getStoryDetailStoryDataResponseDto, StoryDetailStoryDataResponseDto } from './dto/response/detail/story.detail.story.data.response';
import { getStoryDetailUserDataResponseDto, StoryDetailUserDataResponseDto } from './dto/response/detail/story.detail.user.data.response';
import { CreateStoryMetaResponseDto, getCreateStoryMetaResponseDto } from './dto/response/story.create.meta.response.dto';
import { getStoryDetailViewDataResponseJSONDto, StoryDetailViewDataResponseJSONDto } from './dto/response/detail/story.detail.view.data.response.dto';
import { StoryResultDto } from '../search/dto/response/story.result.dto';
import { Transactional } from 'typeorm-transactional';
import { CategoryService } from '../category/category.service';
import { StoryCreateResponseDto } from './dto/response/story-create-response.dto';
import * as dotenv from 'dotenv';
import axios from 'axios';
import { ImageUnhealthyException } from 'src/exception/custom.exception/image.unhealty.exception';
import { strToEmoji } from '../util/util.string.to.badge.content';
import { SearchStoryResultDto } from 'src/search/dto/response/search.story.result.dto';

dotenv.config();

@Injectable()
export class StoryService {
  constructor(
    @Inject('STORY_REPOSITORY')
    private storyRepository: Repository<Story>,
    @Inject(forwardRef(() => UserService))
    private userService: UserService,
    private storyTitleJasoTrie: StoryJasoTrie,
    private categoryService: CategoryService,
  ) {
    this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_10_MINUTES)
  async loadSearchHistoryTrie() {
    this.storyRepository.find({ select: ['storyId', 'title'], relations: ['user'] }).then((everyStory) => {
      everyStory.forEach((story) => this.storyTitleJasoTrie.insert(graphemeSeperation(story.title), story.storyId));
    });
  }

  public async getStory(storyId: number, relations?: object): Promise<Story> {
    return await this.storyRepository.findOne({ where: { storyId: storyId }, relations: relations });
  }

  public async createMetaData(userId: number): Promise<CreateStoryMetaResponseDto> {
    const badgeList: Badge[] = await this.userService.getBadges(userId);
    const categoryList: Category[] = await this.categoryService.getCategoryList();
    return getCreateStoryMetaResponseDto(badgeList, categoryList);
  }

  @Transactional()
  public async create(userId: number, { title, content, categoryId, place, images, badgeId, date }): Promise<StoryCreateResponseDto> {
    const badgeList: Badge[] = await this.userService.getBadges(userId);
    const badge: Badge = badgeList.filter((badge: Badge) => badge.badgeId === badgeId)[0];

    const category: Category = await this.categoryService.getCategory(categoryId);

    const user: User = await this.userService.getUser(userId);

    await Promise.all(
      images.map(async (image) => {
        const data = image.buffer.toString('base64');
        const options = {
          headers: {
            'X-GREEN-EYE-SECRET': `${process.env.GREEN_EYE_SECRET_KEY}`,
            'Content-Type': 'application/json',
          },
        };
        const file = {
          version: 'V1',
          requestId: 'requestId',
          timestamp: Date.now(),
          images: [
            {
              name: 'demo',
              data: `${data}`,
            },
          ],
        };
        const response = await axios.post(process.env.INVOKE_URL, file, options);

        const confidence = response.data.images[0].result.confidence;
        if (confidence < 0.8) throw new ImageUnhealthyException();
      }),
    );

    const story: Story = await createStoryEntity({ title, content, category, place, images, badge, date });
    story.user = Promise.resolve(user);
    await this.storyRepository.save(story);

    if (badge) await this.userService.addBadgeExp({ badgeName: badge.badgeName, userId: userId, exp: 100 });
    return { storyId: story.storyId, badge: { badgeEmoji: `${strToEmoji[story.badge.badgeName]}`, badgeName: story.badge.badgeName, prevExp: badge.badgeExp - 10, nowExp: badge.badgeExp } };
  }

  public async read(userId: number, storyId: number): Promise<StoryDetailViewDataResponseJSONDto> {
    const story: Story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['category', 'user', 'storyImages', 'user.profileImage', 'badge', 'usersWhoLiked', 'user.followers'] });
    const place: Place = await story.place;

    const storyDetailPlaceData: StoryDetailPlaceDataResponseDto = getStoryDetailPlaceDataResponseDto(place);
    const storyDetailStoryData: StoryDetailStoryDataResponseDto = await getStoryDetailStoryDataResponseDto(story, userId, storyDetailPlaceData);

    const user = await story.user;
    const storyDetailUserData: StoryDetailUserDataResponseDto = await getStoryDetailUserDataResponseDto(user, userId);

    return getStoryDetailViewDataResponseJSONDto(storyDetailStoryData, storyDetailUserData);
  }

  @Transactional()
  public async update(userId: number, { storyId, title, content, categoryId, place, images, badgeId, date }): Promise<number> {
    const story: Story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['storyImages', 'category', 'badge', 'place'] });
    const badgeList: Badge[] = await this.userService.getBadges(userId);

    const badge: Badge = badgeList.filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const category: Category = await this.categoryService.getCategory(categoryId);

    const updatedStory = await updateStory(story, { title, content, category, place, images, badge, date });

    await this.storyRepository.save(updatedStory);

    return story.storyId;
  }

  @Transactional()
  public async delete(storyId: number): Promise<void> {
    await this.storyRepository.softDelete(storyId);
  }

  async getStoriesFromTrie(searchText: string, offset: number, limit: number): Promise<StoryResultDto[]> {
    const seperatedStatement = graphemeSeperation(searchText);
    const ids = this.storyTitleJasoTrie.search(seperatedStatement, 100);
    const stories = await this.storyRepository.find({
      select: ['storyId', 'title', 'content', 'likeCount', 'commentCount', 'storyImages', 'category', 'user', 'place'],
      where: {
        storyId: In(ids),
      },
      relations: ['category', 'user'],
    });
    const nonEmptyStoryArr_1 = stories.filter((story) => story !== undefined && story !== null);
    const transformedStories = await Promise.all(
      nonEmptyStoryArr_1.map(async (story) => {
        return await storyEntityToObjWithOneImg(story);
      }),
    );
    const nonEmptyStoryArr_2 = transformedStories.filter((story) => story !== undefined && story !== null);
    return nonEmptyStoryArr_2.slice(offset * limit, offset * limit + limit);
  }

  async getRecommendByLocationStory(locationDto: LocationDTO, offset: number, limit: number): Promise<StoryResultDto[]> {
    const userLatitude = locationDto.latitude;
    const userLongitude = locationDto.longitude;

    const radius = 3;

    const RadiusOfEarth = 6371;

    const stories = await this.storyRepository
      .createQueryBuilder('story')
      .innerJoinAndSelect('story.place', 'place')
      .addSelect(
        `
        (${RadiusOfEarth} * 2 * ATAN2(
          SQRT(
            SIN(RADIANS(place.latitude - ${userLatitude}) / 2) *
            SIN(RADIANS(place.latitude - ${userLatitude}) / 2) +
            COS(RADIANS(${userLatitude})) * COS(RADIANS(place.latitude)) *
            SIN(RADIANS(place.longitude - ${userLongitude}) / 2) *
            SIN(RADIANS(place.longitude - ${userLongitude}) / 2)
          ),
          SQRT(1 - (
            SIN(RADIANS(place.latitude - ${userLatitude}) / 2) *
            SIN(RADIANS(place.latitude - ${userLatitude}) / 2) +
            COS(RADIANS(${userLatitude})) * COS(RADIANS(place.latitude)) *
            SIN(RADIANS(place.longitude - ${userLongitude}) / 2) *
            SIN(RADIANS(place.longitude - ${userLongitude}) / 2)
          ))
        ))`,
        'distance',
      )
      .having('distance <= :radius', { radius })
      .orderBy('distance', 'ASC')
      .offset(offset)
      .limit(limit)
      .getMany();
    const transformedStoryArr = stories.filter((result) => result !== null);

    const storyArr = await Promise.all(
      transformedStoryArr.map(async (story) => {
        return storyEntityToObjWithOneImg(story);
      }),
    );
    const nonEmptyStoryArr = storyArr.filter((story) => story !== undefined && story !== null);
    return nonEmptyStoryArr.slice(offset * limit, offset * limit + limit);
  }

  async getRecommendedStory(offset: number, limit: number): Promise<StoryResultDto[]> {
    try {
      const likeWeight = 2;
      const commentWeight = 2;
      const timeWeight = 1 / (60 * 60 * 24);

      const scoreFormula = `(
      story.likeCount * ${likeWeight} +
      story.commentCount * ${commentWeight} -
      (UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(story.createAt)) * ${timeWeight})`;

      const topStories = await this.storyRepository.createQueryBuilder('story').addSelect(scoreFormula, 'score').orderBy('score', 'DESC').limit(20).cache(30000).getMany();
      const nonEmptyStoryArr = topStories.filter((story) => story !== undefined && story !== null);
      const storyArr = await Promise.all(
        nonEmptyStoryArr.map(async (story) => {
          return storyEntityToObjWithOneImg(story);
        }),
      );
      return storyArr.slice(offset * limit, offset * limit + limit);
    } catch (error) {
      throw error;
    }
  }

  async getFollowStories(userId: number, sortOption: number = 0, offset: number = 0, limit: number = 5): Promise<StoryResultDto[]> {
    const followings = await this.userService.getFollows(userId);
    if (followings.length <= 0) return [];

    const storyPromises = followings.map(async (following) => {
      const stories = await following.stories;
      return stories;
    });

    const allStories = await Promise.all(storyPromises);

    const flattenedStories = allStories.flat();

    const sortedStories = this.sortByOption(flattenedStories, sortOption);

    const storyObjectsPromises = sortedStories.map(async (story) => await storyEntityToObjWithOneImg(story));
    const storyObjects = await Promise.all(storyObjectsPromises);

    return storyObjects.slice(offset * limit, offset * limit + limit);
  }

  private sortByOption(stories: Story[], sortOption: number = 0): Story[] {
    if (sortOption == 0) {
      const sortByCreateDate = (a: Story, b: Story) => new Date(a.createAt).getTime() - new Date(b.createAt).getTime();
      const storiesSortedByCreateDate = [...stories].sort(sortByCreateDate);
      return storiesSortedByCreateDate;
    } else if (sortOption == 1) {
      const sortByLikeCount = (a: Story, b: Story) => b.likeCount - a.likeCount;
      const storiesSortedByLikeCount = [...stories].sort(sortByLikeCount);
      return storiesSortedByLikeCount;
    } else {
      const sortByCommentCount = (a: Story, b: Story) => b.commentCount - a.commentCount;
      const storiesSortedByCommentCount = [...stories].sort(sortByCommentCount);
      return storiesSortedByCommentCount;
    }
  }

  public async addLikeCount(storyId: number) {
    const story = await this.getStory(storyId);
    story.likeCount += 1;
    await this.storyRepository.save(story);

    return story.likeCount;
  }

  public async subLikeCount(storyId: number) {
    const story = await this.getStory(storyId);
    story.likeCount <= 0 ? (story.likeCount = 0) : (story.likeCount -= 1);
    await this.storyRepository.save(story);

    return story.likeCount;
  }

  public async addCommentCount(storyId: number) {
    const story = await this.getStory(storyId);
    story.commentCount += 1;
    await this.storyRepository.save(story);

    return story.likeCount;
  }

  public async subCommentCount(storyId: number) {
    const story = await this.getStory(storyId);
    story.likeCount <= 0 ? (story.likeCount = 0) : (story.likeCount -= 1);
    await this.storyRepository.save(story);

    return story.likeCount;
  }
}
