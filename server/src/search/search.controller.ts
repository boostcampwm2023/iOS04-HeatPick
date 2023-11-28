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
import { storyEntityToObjWithOneImg } from 'src/util/story.entity.to.obj';
import { userEntityToUserObj } from 'src/util/user.entity.to.obj';
import { SearchParameterDto } from './dto/search.parameter.dto';
import { UserResultDto } from './dto/user.result.dto';
import { StoryResultDto } from './dto/story.result.dto';
import { SearchHistoryResultDto } from './dto/search.history.result.dto';
import { SearchUserResultDto } from './dto/search.user.result.dto';

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
    type: [StoryResultDto],
  })
  async getStorySearchResult(@Query('searchText') searchText: string) {
    const stories = await this.storyService.getStoriesFromTrie(graphemeSeperation(searchText), 10);
    const transformedStories = stories.map((story) => storyEntityToObjWithOneImg(story));
    return { stories: transformedStories };
  }

  @Get('user')
  @ApiOperation({ summary: '유저 검색 API' })
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 Username이 유사한 유저를 가져옵니다.',
    type: SearchUserResultDto,
  })
  async getUserSearchResult(@Query('searchText') searchText: string) {
    const users = await this.userService.getUsersFromTrie(graphemeSeperation(searchText), 10);
    const transfromedUsers = users.map((user) => userEntityToUserObj(user));
    return { users: transfromedUsers };
  }

  @ApiOperation({ summary: '검색어 추천 기능' })
  @Get('recommend')
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 유사한 검색어를 가져옵니다.',
    type: SearchHistoryResultDto,
  })
  async recommendSearch(@Query('searchText') searchText: string): Promise<SearchHistoryResultDto> {
    const results = this.searchService.searchHistoryTree(graphemeSeperation(searchText));
    return { histories: results };
  }

  @ApiOperation({ summary: '검색 기능' })
  @ApiResponse({ status: 201, description: '검색어를 바탕으로 스토리와 유저 정보를 5개씩 리턴합니다. 쿼리 파라미터로 categoryId와 searchText를 받으며, categoryId만 입력하는 경우 Id가 일치하는 모든 스토리를 리턴합니다.', type: SearchResultDto })
  @Get()
  async search(@Query() searchParameterDto: SearchParameterDto): Promise<SearchResultDto> {
    const searchText = searchParameterDto.searchText;
    const categoryId = searchParameterDto.categoryId;
    const numericCategoryId: number | undefined = categoryId !== undefined ? +categoryId : undefined;

    const searchStatement = searchText ? searchText : '';
    let stories = await this.storyService.getStoriesFromTrie(graphemeSeperation(searchStatement), 100);
    if (categoryId) stories = stories.filter((story) => story.category && story.category.categoryId === numericCategoryId);

    const storyArr = await Promise.all(
      stories.map(async (story) => {
        return storyEntityToObjWithOneImg(story);
      }),
    );

    const users = await this.userService.getUsersFromTrie(graphemeSeperation(searchStatement), 100);
    const userArr = [];
    if (!categoryId) {
      await Promise.all(
        users.map(async (user) => {
          userArr.push(userEntityToUserObj(user));
        }),
      );
    }

    const truncatedStoryArr = storyArr.splice(0, 5);
    const truncatedUserArr = userArr.splice(0, 5);
    const result: SearchResultDto = { stories: truncatedStoryArr, users: truncatedUserArr };
    return result;
  }
}
