import { StoryService } from './story.service';
import { Body, Controller, Delete, Get, Param, Patch, Post, UploadedFiles, UseInterceptors, ValidationPipe } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { UpdateStoryDto } from './dto/story.update.dto';

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
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Body(new ValidationPipe({ transform: true })) updateStoryDto: UpdateStoryDto) {
    const { storyId, title, content, date } = updateStoryDto;
    return this.storyService.update({ storyId, title, images, content, date });
  }

  @Delete('delete/:storyId')
  @ApiOperation({ summary: 'Delete Story' })
  @ApiResponse({ status: 200, description: '{ }' })
  async delete(@Param('storyId') storyId: number) {
    return this.storyService.delete(storyId);
  }
}
