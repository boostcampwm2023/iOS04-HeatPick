import { Query, Controller, Get, Inject } from '@nestjs/common';
import { SearchService } from './search.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from 'src/user/user.service';
import { StoryService } from './../story/story.service';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { PlaceService } from './../place/place.service';
import { Story } from 'src/entities/story.entity';
import { User } from 'src/entities/user.entity';
import { SearchHistory } from 'src/entities/search.entity';
import { SearchResultDto } from './dto/search.result.dto';
import { profileImage } from './../entities/profileImage.entity';

@ApiTags('search')
@Controller('search')
export class SearchController {
  constructor(
    private searchService: SearchService,
    @Inject(StoryService)
    private storyService: StoryService,
    @Inject(UserService)
    private userService: UserService,
    @Inject(PlaceService)
    private placeService: PlaceService,
  ) {}

  @Get('story')
  @ApiOperation({ summary: '스토리 검색 API' })
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 제목이 유사한 스토리를 가져옵니다.',
    type: [Story],
  })
  async getStorySearchResult(@Query('searchText') searchText: string) {
    return { stories: this.storyService.getStoriesFromTrie(graphemeSeperation(searchText), 10) };
  }

  @Get('user')
  @ApiOperation({ summary: '유저 검색 API' })
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 Username이 유사한 유저를 가져옵니다.',
    type: [User],
  })
  async getUserSearchResult(@Query('searchText') searchText: string) {
    return this.userService.getUsersFromTrie(graphemeSeperation(searchText), 10);
  }

  @Get('place')
  @ApiOperation({ summary: '장소 검색' })
  @ApiResponse({ status: 201 })
  async getPlaceSearchResult(@Query('searchText') searchText: string) {
    return this.placeService.getPlaceFromTrie(graphemeSeperation(searchText));
  }

  @ApiOperation({ summary: '검색어 추천 기능' })
  @ApiResponse({ status: 201, description: '입력된 글자를 바탕으로 자동 완성된 문장 배열을 리턴' })
  @Get('recommend')
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 유사한 검색어를 가져옵니다.',
    type: [SearchHistory],
  })
  async recommendSearch(@Query('searchText') searchText: string): Promise<string[]> {
    return this.searchService.searchHistoryTree(graphemeSeperation(searchText));
  }

  @ApiOperation({ summary: '검색 기능' })
  @ApiResponse({ status: 201, description: '검색어를 바탕으로 스토리와 유저 정보를 5개씩 리턴합니다.' })
  @Get()
  async search(@Query('searchText') searchText: string): Promise<SearchResultDto> {
    const stories = await this.storyService.getStoriesFromTrie(graphemeSeperation(searchText), 5);
    const storyArr = [];
    await Promise.all(
      stories.map(async (story) => {
        const images = await story.storyImages;
        const urls = images.map((image) => image.imageUrl);
        storyArr.push({ title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, createAt: story.createAt, storyImages: urls });
      }),
    );

    const users = await this.userService.getUsersFromTrie(graphemeSeperation(searchText), 5);

    const userArr = [];
    await Promise.all(
      users.map(async (user) => {
        const image = user.profileImage;
        const url = image?.imageUrl;
        userArr.push({ userId: user.userId, username: user.username, temperature: user.temperature, createdAt: user.createAt, recentlyActive: user.recentActive, profileImage: url });
      }),
    );

    const result: SearchResultDto = { stories: storyArr, users: userArr };
    return result;
  }
}
