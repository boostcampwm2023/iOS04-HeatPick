import { StoryService } from './story.service';
import { Body, Controller, Delete, Get, Headers, Patch, Post, UploadedFiles, UseInterceptors, ValidationPipe, Query, ParseIntPipe } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { UpdateStoryDto } from './dto/story.update.dto';
import { LocationDTO } from 'src/place/dto/location.dto';;
import { RecommendStoryDto } from './dto/story.recommend.response.dto';
import { plainToClass } from 'class-transformer';
import { StoryDetailViewDataDto } from './dto/detail/story.detail.view.data.dto';

@ApiTags('story')
@Controller('story')
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Post('create')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Create story' })
  @ApiResponse({
    status: 200,
    description: 'storyId',
    schema: {
      type: 'object',
      properties: {
        storyId: { type: 'number' },
      },
    },
  })
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Headers('accessToken') accessToken: string, @Body(new ValidationPipe({ transform: true })) createStoryDto: CreateStoryDto) {
    const { title, content, category, place, badgeId, date } = createStoryDto;
    const storyId = await this.storyService.create(accessToken, { title, content, category, place, images, badgeId, date });
    return { storyId: storyId };
  }

  @Get('detail')
  @ApiOperation({ summary: 'Send detail story info' })
  @ApiCreatedResponse({
    status: 200,
    description: '성공',
    type: StoryDetailViewDataDto,
  })
  async read(@Headers('accessToken') accessToken: string, @Query('storyId', ParseIntPipe) storyId: number)  {
    return await this.storyService.read(accessToken, storyId);
  }

  @Patch('edit')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: 'Update story' })
  @ApiResponse({
    status: 200,
    description: 'storyId',
    schema: {
      type: 'object',
      properties: {
        storyId: { type: 'number' },
      },
    },
  })
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Headers('accessToken') accessToken: string, @Body(new ValidationPipe({ transform: true })) updateStoryDto: UpdateStoryDto) {
    const { storyId, title, content, category, place, badgeId, date } = updateStoryDto;
    const newStoryId = await this.storyService.update(accessToken, { storyId, title, content, category, place, images, badgeId, date });
    return { storyId: newStoryId };
  }

  @Delete('delete')
  @ApiOperation({ summary: 'Delete Story' })
  @ApiResponse({
    status: 200,
    description: '성공',
    schema: {
      type: 'object',
      properties: {
        storyId: { type: 'number' },
      },
    },
  })
  async delete(@Headers('accessToken') accessToken: string, @Query('storyId', ParseIntPipe) storyId: number) {
    await this.storyService.delete(accessToken, storyId);
    return { storyId: storyId };
  }

  @Get('recommend/location')
  @ApiOperation({ summary: '현재 위치를 기반으로 추천 장소를 가져옵니다. 기본적으로, 좋아요가 10개 초과인 경우만 리턴됩니다.' })
  @ApiResponse({ status: 201, description: '추천 스토리를 key-value 형태의 JSON 객체로 리턴합니다(value는 array)', type: RecommendStoryDto, isArray: true })
  async recommendStoryByLocation(@Query() locationDto: LocationDTO) {
    const transformedDto = plainToClass(LocationDTO, locationDto);
    const recommededStory = await this.storyService.getRecommendByLocationStory(transformedDto);
    return { recommededStories: recommededStory };
  }

  @Get('recommend')
  @ApiOperation({ summary: '위치와 관계 없이, 추천 장소를 가져옵니다. 기본적으로, 좋아요가 10개 초과인 경우만 리턴됩니다.' })
  @ApiResponse({ status: 201, description: '추천 스토리를 key-value 형태의 JSON 객체로 리턴합니다(value는 array)', type: RecommendStoryDto, isArray: true })
  async recommendStory() {
    const recommededStory = await this.storyService.getRecommendedStory();
    return { recommededStories: recommededStory };
  }
}
