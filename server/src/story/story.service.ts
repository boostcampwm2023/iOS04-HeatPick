import { Injectable, Inject } from '@nestjs/common';
import { Story } from '../entities/story.entity';
import { StoryJasoTrie } from 'src/search/trie/storyTrie';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { createStoryEntity } from '../util/util.create.story.entity';
import { Cron, CronExpression } from '@nestjs/schedule';
import { LocationDTO } from 'src/place/dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
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
import { removeMillisecondsFromISOString } from '../util/util.date.format.to.ISO8601';
import { strToEmoji, strToExplain } from 'src/util/util.string.to.badge.content';
import { updateStory } from '../util/util.story.update';
import { In, Repository } from 'typeorm';

@Injectable()
export class StoryService {
  private searchStoryResultCache = {};
  private recommendStoryCache = [];
  constructor(
    @Inject('STORY_REPOSITORY')
    private storyRepository: Repository<Story>,
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
    private storyTitleJasoTrie: StoryJasoTrie,
    private categoryRepository: CategoryRepository,
    private userService: UserService,
  ) {
    this.loadSearchHistoryTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  async loadSearchHistoryTrie() {
    this.recommendStoryCache = [];
    this.searchStoryResultCache = {};
    this.storyRepository.find({ relations: ['user'] }).then((everyStory) => {
      everyStory.forEach((story) => this.storyTitleJasoTrie.insert(graphemeSeperation(story.title), story.storyId));
    });
  }

  public async createMetaData(userId: string) {
    const user: User = await this.userRepository.findOne({ where: { oauthId: userId }, relations: ['badges'] });
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
    const user: User = await this.userRepository.findOne({ where: { oauthId: userId }, relations: ['badges'] });
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const category: Category = await this.categoryRepository.findById(categoryId);
    const story: Story = await createStoryEntity({ title, content, category, place, images, badge, date });
    user.stories = Promise.resolve([...(await user.stories), story]);
    await this.userRepository.save(user);
    if (badge) this.userService.addBadgeExp({ badgeName: badge.badgeName, userId: user.userId, exp: 10 });
    return story.storyId;
  }

  public async read(userId: number, storyId: number) {
    const story: Story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['category', 'user', 'storyImages', 'user.profileImage', 'badge', 'usersWhoLiked', 'user.followers'] });
    const place: Place = await story.place;

    const storyDetailPlaceData: StoryDetailPlaceDataDto = {
      title: place.title,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
    };

    const storyDetailStoryData: StoryDetailStoryDataDto = {
      storyId: story.storyId,
      createdAt: removeMillisecondsFromISOString(story.createAt.toISOString()),
      category: story.category.categoryName,
      storyImageURL: (await story.storyImages).map((storyImage: StoryImage) => storyImage.imageUrl),
      title: story.title,
      badgeName: `${strToEmoji[story.badge?.badgeName]}${story.badge?.badgeName}`,
      badgeDescription: strToExplain[`${story.badge?.badgeName}`],
      likeState: (await story.usersWhoLiked).some((user) => user.userId === userId) ? 0 : 1,
      likeCount: story.likeCount,
      commentCount: story.commentCount,
      content: story.content,
      place: storyDetailPlaceData,
    };
    const user = await story.user;
    const userImage = await user.profileImage;
    const storyDetailUserData: StoryDetailUserDataDto = {
      userId: user.userId,
      username: user.username,
      profileImageUrl: userImage.imageUrl,
      status: userId === user.userId ? 0 : user.followers.some((user) => user.userId === userId) ? 2 : 1,
    };

    const storyDetailViewData: StoryDetailViewDataDto = {
      story: storyDetailStoryData,
      author: storyDetailUserData,
    };

    return storyDetailViewData;
  }

  public async update(userId: string, { storyId, title, content, categoryId, place, images, badgeId, date }): Promise<number> {
    const user: User = await this.userRepository.findOne({ where: { oauthId: userId } });
    const story: Story = await this.storyRepository.findOne({ where: { storyId: storyId }, relations: ['storyImages', 'category', 'badge', 'place'] });
    const badge: Badge = (await user.badges).filter((badge: Badge) => badge.badgeId === badgeId)[0];
    const category: Category = await this.categoryRepository.findById(categoryId);

    const updatedStory = await updateStory(story, { title, content, category, place, images, badge });

    await this.storyRepository.save(updatedStory);

    return story.storyId;
  }

  public async delete(userId: string, storyId: number) {
    const user: User = await this.userRepository.findOne({ where: { oauthId: userId } });
    user.stories = Promise.resolve((await user.stories).filter((story) => story.storyId !== storyId));
    await this.userRepository.save(user);
  }

  async getStoriesFromTrie(searchText: string, offset: number, limit: number): Promise<Story[]> {
    if (!this.searchStoryResultCache.hasOwnProperty(searchText)) {
      const seperatedStatement = graphemeSeperation(searchText);
      const ids = this.storyTitleJasoTrie.search(seperatedStatement, 100);
      const stories = await this.storyRepository.find({
        where: {
          storyId: In(ids),
        },
        relations: ['category', 'user'],
      });
      this.searchStoryResultCache[searchText] = stories;
    }

    const results = this.searchStoryResultCache[searchText];
    return results.slice(offset * limit, offset * limit + limit);
  }

  public async like(userId: number, storyId: number) {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId } });
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });

    story.likeCount += 1;
    (await user.likedStories).push(story);

    await this.storyRepository.save(story);
    await this.userRepository.save(user);

    const updatedStory = await this.storyRepository.findOne({ where: { storyId: storyId } });

    return updatedStory.likeCount;
  }

  public async unlike(userId: number, storyId: number) {
    const story = await this.storyRepository.findOne({ where: { storyId: storyId } });
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['likedStories'] });

    story.likeCount <= 0 ? (story.likeCount = 0) : (story.likeCount -= 1);
    user.likedStories = Promise.resolve((await user.likedStories).filter((story) => story.storyId === storyId));

    await this.storyRepository.save(story);
    await this.userRepository.save(user);

    const updatedStory = await this.storyRepository.findOne({ where: { storyId: storyId } });

    return updatedStory.likeCount;
  }

  async getRecommendByLocationStory(locationDto: LocationDTO, offset: number, limit: number) {
    const stories = await this.storyRepository.find({ relations: ['user', 'category'] });

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

    const transformedStoryArr = results.filter((result) => result !== null);

    const storyArr = await Promise.all(
      transformedStoryArr.map(async (story) => {
        return storyEntityToObjWithOneImg(story);
      }),
    );
    return storyArr.slice(offset * limit, offset * limit + limit);
  }

  async getRecommendedStory(offset: number, limit: number) {
    try {
      if (this.recommendStoryCache.length <= 0) {
        const stories = await this.storyRepository.find({
          order: {
            likeCount: 'DESC',
          },
          relations: ['user', 'user.profileImage', 'storyImages', 'category'],
        });

        const storyArr = await Promise.all(
          stories.map(async (story) => {
            return storyEntityToObjWithOneImg(story);
          }),
        );

        this.recommendStoryCache = storyArr;
      }

      return this.recommendStoryCache.slice(offset * limit, offset * limit + limit);
    } catch (error) {
      throw error;
    }
  }

  async getFollowStories(userId: number, sortOption: number = 0, offset: number = 0, limit: number = 5) {
    const user = await this.userRepository.findOne({ where: { userId: userId }, relations: ['following', 'profileImage'] });
    const followings = user.following;

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

  private sortByOption(stories: Story[], sortOption: number = 0) {
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
}
