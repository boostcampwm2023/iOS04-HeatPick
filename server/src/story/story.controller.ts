import { StoryService } from './story.service';
import { Body, Controller, Delete, Get, Patch, Post, UploadedFiles, UseInterceptors, ValidationPipe, Query, ParseIntPipe, UseGuards, Request } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation, ApiQuery, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateStoryDto } from './dto/story.create.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { UpdateStoryDto } from './dto/story.update.dto';
import { LocationDTO } from 'src/place/dto/location.dto';
import { RecommendStoryDto } from './dto/story.recommend.response.dto';
import { plainToClass } from 'class-transformer';
import { StoryDetailViewDataDto } from './dto/detail/story.detail.view.data.dto';
import { JwtAuthGuard } from 'src/auth/jwt.guard';
import { CreateStoryMetaDto } from './dto/story.create.meta.dto';
import { StoryRecommendResponseDto, StoryResultDto } from 'src/search/dto/story.result.dto';

@ApiTags('story')
@Controller('story')
@UseGuards(JwtAuthGuard)
export class StoryController {
  constructor(private storyService: StoryService) {}

  @Get('meta')
  @ApiOperation({ summary: '스토리 생성시 필요한 뱃지와 카테고리 리스트 불러오기' })
  @ApiResponse({
    status: 200,
    description: '생성하는 유저의 카테고리와 뱃지',
    type: CreateStoryMetaDto,
  })
  async meta(@Request() req: any): Promise<CreateStoryMetaDto> {
    return await this.storyService.createMetaData(req.user.userId);
  }

  @Post('create')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: '스토리 생성' })
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
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Request() req: any, @Body(new ValidationPipe({ transform: true })) createStoryDto: CreateStoryDto) {
    const { title, content, categoryId, place, badgeId, date } = createStoryDto;
    const storyId = await this.storyService.create(req.user.userId, { title, content, categoryId, place, images, badgeId, date });
    return { storyId: storyId };
  }

  @Get('detail')
  @ApiOperation({ summary: '스토리 상세 정보' })
  @ApiCreatedResponse({
    status: 200,
    description: '성공',
    type: StoryDetailViewDataDto,
  })
  async read(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number) {
    return await this.storyService.read(req.user.userId, storyId);
  }

  @Patch('edit')
  @UseInterceptors(FilesInterceptor('images', 3))
  @ApiOperation({ summary: '스토리 수정' })
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
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Request() req: any, @Body(new ValidationPipe({ transform: true })) updateStoryDto: UpdateStoryDto) {
    const { storyId, title, content, categoryId, place, badgeId, date } = updateStoryDto;
    const newStoryId = await this.storyService.update(req.user.userId, { storyId, title, content, categoryId, place, images, badgeId, date });
    return { storyId: newStoryId };
  }

  @Delete('delete')
  @ApiOperation({ summary: '스토리 삭제' })
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
  async delete(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number) {
    await this.storyService.delete(req.user.userId, storyId);
    return { storyId: storyId };
  }

  @Get('recommend/location')
  @ApiOperation({ summary: '현재 위치를 기반으로 추천 장소를 가져옵니다. ' })
  @ApiQuery({ name: 'offset', required: false, type: Number })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiResponse({ status: 200, description: '추천 스토리를 key-value 형태의 JSON 객체로 리턴합니다(value는 array)', type: StoryRecommendResponseDto })
  async recommendStoryByLocation(@Query() locationDto: LocationDTO, @Query('offset') offset: number = 0, @Query('limit') limit: number = 5): Promise<StoryRecommendResponseDto> {
    const transformedDto = plainToClass(LocationDTO, locationDto);
    const recommededStories = await this.storyService.getRecommendByLocationStory(transformedDto, offset, limit);
    const isLastPage = recommededStories.length < limit ? true : false;
    return { recommededStories: recommededStories, isLastPage: isLastPage };
  }

  @Get('recommend')
  @ApiOperation({ summary: '위치와 관계 없이, 추천 장소를 가져옵니다. ' })
  @ApiQuery({ name: 'offset', required: false, type: Number })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiResponse({ status: 200, description: '추천 스토리를 key-value 형태의 JSON 객체로 리턴합니다(value는 array)', type: StoryRecommendResponseDto })
  async recommendStory(@Query('offset') offset: number = 0, @Query('limit') limit: number = 5): Promise<StoryRecommendResponseDto> {
    const recommededStories = await this.storyService.getRecommendedStory(offset, limit);
    const isLastPage = recommededStories.length < limit ? true : false;
    return { recommededStories: recommededStories, isLastPage: isLastPage };
  }
}
