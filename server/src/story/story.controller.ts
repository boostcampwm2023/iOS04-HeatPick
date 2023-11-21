import { StoryService } from './story.service';
import {
  Body,
  Controller,
  Delete,
  Get,
  Headers,
  Param,
  Patch,
  Post,
  UploadedFiles,
  UseInterceptors,
  ValidationPipe,
} from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { StoryDetailViewData } from './type/story.detail.view.data';
import { UpdateStoryDto } from './dto/story.update.dto';

@ApiTags('story')
@Controller('story')
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Post('create')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Create story' })
  @ApiResponse({ status: 200, description: 'storyId' })
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Headers('accessToken') accessToken: string, @Body(new ValidationPipe({ transform: true })) createStoryDto: CreateStoryDto) {
    const { title, content, category, place, date } = createStoryDto;
    return this.storyService.create(accessToken, { title, content, category, place, images, date });
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
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Headers('accessToken') accessToken: string, @Body(new ValidationPipe({ transform: true })) updateStoryDto: UpdateStoryDto) {
    const { storyId, title, content, category, place, date } = updateStoryDto;
    return this.storyService.update(accessToken, { storyId, title, content, category, place, images, date });
  }

  @Delete('delete/:storyId')
  @ApiOperation({ summary: 'Delete Story' })
  @ApiResponse({ status: 200, description: '{ }' })
  async delete(@Headers('accessToken') accessToken: string, @Param('storyId') storyId: number) {
    return this.storyService.delete(accessToken, storyId);
  }
}
