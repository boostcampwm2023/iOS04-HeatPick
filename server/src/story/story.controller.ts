import { StoryService } from './story.service';
import { Body, Controller, Delete, Get, Patch, Post, UploadedFiles, UseInterceptors, ValidationPipe, Query, ParseIntPipe, UseGuards, Request } from '@nestjs/common';
import { ApiCreatedResponse, ApiOperation, ApiQuery, ApiResponse, ApiTags } from '@nestjs/swagger';
import { FilesInterceptor } from '@nestjs/platform-express';
import { LocationDTO } from 'src/place/dto/location.dto';
import { plainToClass } from 'class-transformer';
import { JwtAuthGuard } from 'src/auth/jwt.guard';
import { StoryRecommendResponseDto } from 'src/search/dto/response/story.result.dto';
import { CreateStoryRequestDto } from './dto/request/story.create.request.dto';
import { UpdateStoryRequestDto } from './dto/request/story.update.request.dto';
import { CreateStoryMetaResponseDto, CreateStoryMetaResponseJSONDto } from './dto/response/story.create.meta.response.dto';
import { StoryDetailViewDataResponseJSONDto } from './dto/response/detail/story.detail.view.data.response.dto';

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
    type: CreateStoryMetaResponseJSONDto,
  })
  async meta(@Request() req: any): Promise<CreateStoryMetaResponseJSONDto> {
    const meta: CreateStoryMetaResponseDto = await this.storyService.createMetaData(req.user.userRecordId);
    return { meta: meta };
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
  async create(@UploadedFiles() images: Array<Express.Multer.File>, @Request() req: any, @Body(new ValidationPipe({ transform: true })) createStoryRequestDto: CreateStoryRequestDto): Promise<{ storyId: number }> {
    const { title, content, categoryId, place, badgeId, date } = createStoryRequestDto;
    const storyId = await this.storyService.create(req.user.userId, { title, content, categoryId, place, images, badgeId, date });
    return { storyId: storyId };
  }

  @Get('detail')
  @ApiOperation({ summary: '스토리 상세 정보', description: '0: 본인, 1: 언팔로우 상태, 2: 팔로우 상태' })
  @ApiCreatedResponse({
    status: 200,
    description: '성공',
    type: StoryDetailViewDataResponseJSONDto,
  })
  async read(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number): Promise<StoryDetailViewDataResponseJSONDto> {
    return await this.storyService.read(req.user.userRecordId, storyId);
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
  async update(@UploadedFiles() images: Array<Express.Multer.File>, @Request() req: any, @Body(new ValidationPipe({ transform: true })) updateStoryRequestDto: UpdateStoryRequestDto): Promise<{ storyId: number }> {
    const { storyId, title, content, categoryId, place, badgeId, date } = updateStoryRequestDto;
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
  async delete(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number): Promise<{ storyId: number }> {
    await this.storyService.delete(req.user.userId, storyId);
    return { storyId: storyId };
  }

  @Post('like')
  @ApiOperation({ summary: '스토리 좋아요' })
  @ApiCreatedResponse({
    status: 200,
    description: '성공',
    schema: {
      type: 'object',
      properties: {
        likeCount: { type: 'number' },
      },
    },
  })
  async addLike(@Request() req: any, @Query('storyId') storyId: number): Promise<{ likeCount: number }> {
    const likeCount = await this.storyService.like(req.user.userRecordId, storyId);
    return { likeCount: likeCount };
  }

  @Post('unlike')
  @ApiOperation({ summary: '스토리 좋아요 취소' })
  @ApiCreatedResponse({
    status: 200,
    description: '성공',
    schema: {
      type: 'object',
      properties: {
        likeCount: { type: 'number' },
      },
    },
  })
  async unlike(@Request() req: any, @Query('storyId') storyId: number): Promise<{ likeCount: number }> {
    const likeCount = await this.storyService.unlike(req.user.userRecordId, storyId);
    return { likeCount: likeCount };
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

  @Get('follow')
  @ApiOperation({ summary: '팔로우한 유저들의 스토리 정보를 가져옵니다.' })
  @ApiQuery({ name: 'offset', required: false, type: Number })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiQuery({ name: 'sortOption', required: false, type: Number })
  @ApiResponse({ status: 200, description: '추천 스토리를 key-value 형태의 JSON 객체로 리턴합니다. sortOption은 디폴트 값은 0이며, 0은 최신, 1은 좋아요, 2는 댓글 순으로 정렬됩니다.', type: StoryRecommendResponseDto })
  async getFollowStories(@Request() req: any, @Query('offset') offset: number = 0, @Query('limit') limit: number = 5, @Query('sortOption') sortOption: number = 0): Promise<StoryRecommendResponseDto> {
    const userId = req.user.userRecordId;
    const stories = await this.storyService.getFollowStories(userId, sortOption, offset, limit);
    const isLastPage = stories.length < limit ? true : false;
    return { recommededStories: stories, isLastPage: isLastPage };
  }
}
