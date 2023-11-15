import { StoryService } from './story.service';
import { Body, Controller, Get, Param, Post, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { saveImage } from '../util/story.util.saveImage';
import { JwtAuthGuard } from 'src/auth/jwt.guard';
import { Story } from '../entities/story.entity';

@UseGuards(JwtAuthGuard)
@Controller('story')
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Post('create')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Create story' })
  @ApiResponse({ status: 200, description: 'storyId' })
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Body() createStoryDto: CreateStoryDto) {
    const savedImagePaths = await Promise.all(images.map(async (image) => await saveImage('../../uploads', image.buffer)));

    const { title, content, date } = createStoryDto;

    return this.storyService.create({ title, content, savedImagePaths, date });
  }

  @Get('detail/:storyId')
  @ApiOperation({ summary: 'Send detail story info' })
  @ApiResponse({ status: 200, description: '{ story, isfollowd, recommandStoryList, author }' })
  async read(@Param('storyId') storyId: number): Promise<Story> {
    return this.storyService.read(storyId);
  }
}
