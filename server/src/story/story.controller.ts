import { StoryService } from './story.service';
import { Body, Controller, Post, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { saveImage } from '../util/story.util.saveImage';
import { JwtAuthGuard } from 'src/auth/jwt.guard';

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
}
