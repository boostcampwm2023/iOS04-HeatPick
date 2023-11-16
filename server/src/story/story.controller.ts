import { StoryService } from './story.service';
import { Body, Controller, Get, Param, Patch, Post, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { StoryDetailViewData } from './type/story.detail.view.data';

@Controller('story')
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Post('create')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Create story' })
  @ApiResponse({ status: 200, description: 'storyId' })
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Body() createStoryDto: CreateStoryDto) {
    const { title, content, date } = createStoryDto;
    return this.storyService.create({ title, content, images, date });
  }

  @Get('detail/:storyId')
  @ApiOperation({ summary: 'Send detail story info' })
  @ApiResponse({ status: 200, description: '{ story, isFollowed, recommendStoryList, author }' })
  async read(@Param('storyId') storyId: number): Promise<StoryDetailViewData> {
    return this.storyService.read(storyId);
  }

  @Patch('edit')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Update story' })
  @ApiResponse({ status: 200, description: '{ }' })
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Body() createStoryDto: CreateStoryDto) {
    const { title, content, date } = createStoryDto;
    return this.storyService.update({ title, content, images, date });
  }
}
