import { Query, Controller, Get } from '@nestjs/common';
import { SearchService } from './search.service';

@Controller('search')
export class SearchController {
  constructor(private searchService: SearchService) {}

  @Get('')
  async getSearchResult(@Query('searchText') searchText: string) {
    this.searchService.saveHistory(searchText);
  }

  @Get('recommend')
  async recommendSearch(@Query('searchText') searchText: string): Promise<string[]> {
    return this.searchService.searchTree(this.searchService.graphemeSeparation(searchText));
  }
}
