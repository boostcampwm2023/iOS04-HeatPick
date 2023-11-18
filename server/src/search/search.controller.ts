import { Query, Controller, Get, Inject } from '@nestjs/common';
import { SearchService } from './search.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from 'src/user/user.service';
import { StoryService } from './../story/story.service';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { PlaceService } from './../place/place.service';

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
  @ApiOperation({ summary: '스토리 검색' })
  @ApiResponse({ status: 201 })
  async getStorySearchResult(@Query('searchText') searchText: string) {
    return this.storyService.getStoriesFromTrie(graphemeSeperation(searchText));
  }

  @Get('user')
  @ApiOperation({ summary: '유저 검색' })
  @ApiResponse({ status: 201 })
  async getUserSearchResult(@Query('searchText') searchText: string) {
    return this.userService.getUsersFromTrie(graphemeSeperation(searchText));
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
  async recommendSearch(@Query('searchText') searchText: string): Promise<string[]> {
    return this.searchService.searchHistoryTree(graphemeSeperation(searchText));
  }
}
