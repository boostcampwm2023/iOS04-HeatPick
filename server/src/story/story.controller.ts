import { StoryService } from './story.service';
import { Body, Controller, Post } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';

@Controller('story')
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Post('create')
  @ApiOperation({ summary: 'Create story' })
  @ApiResponse({ status: 200, description: 'storyId' })
  async create(@Body() createStoryDto: CreateStoryDto): Promise<number> {
    const { title, content, imageList, date } = createStoryDto;

    return this.storyService.create({ title, content, imageList, date });
  }
}
