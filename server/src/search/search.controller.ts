import { Query, Controller, Get } from '@nestjs/common';
import { SearchService } from './search.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('search')
@Controller('search')
export class SearchController {
  constructor(private searchService: SearchService) {}

  @Get('')
  @ApiOperation({ summary: '검색 기능' })
  @ApiResponse({ status: 201 })
  async getSearchResult(@Query('searchText') searchText: string) {
    this.searchService.saveHistory(searchText);
  }

  @ApiOperation({ summary: '검색어 추천 기능' })
  @ApiResponse({ status: 201, description: '입력된 글자를 바탕으로 자동 완성된 문장 배열을 리턴' })
  @Get('recommend')
  async recommendSearch(@Query('searchText') searchText: string): Promise<string[]> {
    return this.searchService.searchTree(this.searchService.graphemeSeparation(searchText));
  }
}
