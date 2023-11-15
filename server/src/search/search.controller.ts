import { Controller, Get } from '@nestjs/common';

@Controller('search')
export class SearchController {
  @Get('recommend')
  async recommendSearch(): Promise<any> {
    return 1;
  }
}
