import { Query, Controller, Get, Inject, UseGuards } from '@nestjs/common';
import { SearchService } from './search.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from 'src/user/user.service';
import { StoryService } from './../story/story.service';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { PlaceService } from './../place/place.service';
import { SearchResultDto } from './dto/response/search.result.dto';
import { storyEntityToObjWithOneImg } from 'src/util/story.entity.to.obj';
import { userEntityToUserObj } from 'src/util/user.entity.to.obj';
import { SearchParameterDto } from './dto/request/search.parameter.dto';
import { SearchHistoryResultDto } from './dto/response/search.history.result.dto';
import { SearchUserResultDto } from './dto/response/search.user.result.dto';
import { SearchStoryResultDto } from './dto/response/search.story.result.dto';
import { JwtAuthGuard } from 'src/auth/jwt.guard';

@ApiTags('search')
@Controller('search')
@UseGuards(JwtAuthGuard)
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
    type: SearchStoryResultDto,
  })
  async getStorySearchResult(@Query('searchText') searchText: string, @Query('offset') offset: number, @Query('limit') limit: number): Promise<SearchStoryResultDto> {
    const stories = await this.storyService.getStoriesFromTrie(searchText, offset, limit);
    const transformedStories = await Promise.all(
      stories.map(async (story) => {
        return await storyEntityToObjWithOneImg(story);
      }),
    );
    const isLastPage = transformedStories.length < limit ? true : false;
    return { stories: transformedStories, isLastPage: isLastPage };
  }

  @Get('user')
  @ApiOperation({ summary: '유저 검색 API' })
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 Username이 유사한 유저를 가져옵니다.',
    type: SearchUserResultDto,
  })
  async getUserSearchResult(@Query('searchText') searchText: string, @Query('offset') offset: number, @Query('limit') limit: number): Promise<SearchUserResultDto> {
    const users = await this.userService.getUsersFromTrie(searchText, offset, limit);
    const transfromedUsers = await Promise.all(users.map(async (user) => await userEntityToUserObj(user)));
    const isLastPage = transfromedUsers.length < limit ? true : false;
    return { users: transfromedUsers, isLastPage: isLastPage };
  }

  @ApiOperation({ summary: '검색어 추천 기능' })
  @Get('recommend')
  @ApiResponse({
    status: 201,
    description: '파라미터로 넘겨받은 searchText 값을 바탕으로 유사한 검색어를 가져옵니다.',
    type: SearchHistoryResultDto,
  })
  async recommendSearch(@Query('searchText') searchText: string): Promise<SearchHistoryResultDto> {
    const results = await this.searchService.searchRecommend(searchText);
    return { recommends: results };
  }

  @ApiOperation({ summary: '검색 기능' })
  @ApiResponse({ status: 201, description: '검색어를 바탕으로 스토리와 유저 정보를 5개씩 리턴합니다. 쿼리 파라미터로 categoryId와 searchText를 받으며, categoryId만 입력하는 경우 Id가 일치하는 모든 스토리를 리턴합니다.', type: SearchResultDto })
  @Get()
  async search(@Query() searchParameterDto: SearchParameterDto): Promise<SearchResultDto> {
    const searchText = searchParameterDto.searchText;
    const categoryId = searchParameterDto.categoryId;
    const numericCategoryId: number | undefined = categoryId !== undefined ? +categoryId : undefined;

    const searchStatement = searchText ? searchText : '';
    let stories = await this.storyService.getStoriesFromTrie(searchStatement, 0, 5);
    if (categoryId) stories = stories.filter((story) => story.category && story.category.categoryId === numericCategoryId);

    const storyArr = await Promise.all(
      stories.map(async (story) => {
        return storyEntityToObjWithOneImg(story);
      }),
    );

    const users = await this.userService.getUsersFromTrie(searchStatement, 0, 5);

    const userArr = [];
    if (!categoryId) {
      await Promise.all(
        users.map(async (user) => {
          userArr.push(await userEntityToUserObj(user));
        }),
      );
    }

    const truncatedStoryArr = storyArr.splice(0, 5);
    const truncatedUserArr = userArr.splice(0, 5);
    const result: SearchResultDto = { stories: truncatedStoryArr, users: truncatedUserArr };

    return result;
  }
}
