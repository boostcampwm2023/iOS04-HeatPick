import {
  Body,
  Controller,
  Get,
  Patch,
  Post,
  Query,
  Headers,
  UseInterceptors,
  UploadedFile,
  Delete,
  Put,
  ParseIntPipe,
  ValidationPipe,
  Param,
  UseGuards,
  Req,
  Request,
} from '@nestjs/common';
import { ApiBody, ApiCreatedResponse, ApiOperation, ApiQuery, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/request/addBadge.dto';
import { AddBadgeExpDto } from './dto/request/addBadgeExp.dto';
import { plainToClass } from 'class-transformer';
import { UserUpdateDto } from './dto/request/user.update.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { FollowRequest } from './dto/request/follow.request.dto';
import { UserProfileDetailJsonDto } from './dto/response/user.profile.detail.data.dto';
import { userEntityToUserObj } from 'src/util/user.entity.to.obj';
import { JwtAuthGuard } from 'src/auth/jwt.guard';
import { BadgeJsonDto, BadgeReturnDto } from './dto/response/badge.return.dto';
import { strToEmoji, strToExplain } from 'src/util/util.string.to.badge.content';
import { UserJsonResponseDto } from './dto/response/user.response.dto';
import { ProfileUpdateMetaDataJsonDto } from './dto/response/profile.update.meta.dto';
import { UserProfileDetailStoryJsonDto } from './dto/response/user.profile.detail.story.dto';
import { StoryRecommendResponseDto } from '../search/dto/response/story.result.dto';

@ApiTags('user')
@Controller('user')
@UseGuards(JwtAuthGuard)
export class UserController {
  constructor(private userService: UserService) {}

  @Get('badge')
  @ApiOperation({ summary: '유저의 모든 뱃지를 리턴합니다..' })
  @ApiResponse({ status: 200, type: BadgeReturnDto, isArray: true })
  async getBadges(@Req() req: any): Promise<BadgeJsonDto> {
    const badges = await this.userService.getBadges(req.user.userRecordId);
    const transformedBadges: BadgeReturnDto[] = badges.map((badge) => {
      return { badgeId: badge.badgeId, badgeName: badge.badgeName, emoji: strToEmoji[badge.badgeName], description: strToExplain[badge.badgeName] };
    });
    return { badges: transformedBadges };
  }

  @Post('badge')
  @ApiOperation({ summary: '유제 객체에 새로운 뱃지를 추가합니다.' })
  @ApiResponse({ status: 200, description: 'Badge가 성공적으로 추가되었습니다.' })
  async addBadge(@Body() addBadgeDto: AddBadgeDto) {
    return this.userService.addNewBadge(addBadgeDto);
  }

  @Get('profile')
  @ApiOperation({ summary: '유저 ID로 Profile를 불러옵니다.' })
  @ApiCreatedResponse({ status: 201, description: 'Profile을 성공적으로 불러왔습니다.', type: UserProfileDetailJsonDto })
  async getProfile(@Req() req: any, @Query('userId', ParseIntPipe) userId: number): Promise<UserProfileDetailJsonDto> {
    const profile = await this.userService.getProfile(req.user.userRecordId, userId);
    return { profile: profile };
  }

  @Get('myProfile')
  @ApiOperation({ summary: '자신의 토큰으로 자신의 Profile을 불러옵니다.' })
  @ApiCreatedResponse({ status: 201, description: 'My Profile을 성공적으로 불러왔습니다.', type: UserProfileDetailJsonDto })
  async getMyProfile(@Req() req: any): Promise<UserProfileDetailJsonDto> {
    const profile = await this.userService.getProfile(req.user.userRecordId, req.user.userRecordId);
    return { profile: profile };
  }

  @Put('badge')
  @ApiOperation({ summary: '유저 객체의 대표 뱃지를 설정합니다.' })
  @ApiResponse({ status: 200, description: '대표 뱃지가 성공적으로 변경되었습니다.' })
  async setRepresentatvieBadge(@Body() setBadgeDto: AddBadgeDto) {
    return this.userService.setRepresentatvieBadge(setBadgeDto);
  }

  @Put('badge/exp')
  @ApiOperation({ summary: '유저 객체의 뱃지 경험치를 증가시킵니다.' })
  @ApiResponse({ status: 200, description: '뱃지에 경험치가 성공적으로 반영되었습니다..' })
  async addBadgeExp(@Body() addBadgeExpDto: AddBadgeExpDto) {
    const transformedDto = plainToClass(AddBadgeExpDto, addBadgeExpDto);
    return this.userService.addBadgeExp(transformedDto);
  }
  @Get('story')
  @ApiOperation({ summary: `해당 userId에 해당하는 유저의 스토리를 모두 불러옵니다.` })
  @ApiResponse({ status: 201, description: '사용자의 StoryList를 성공적으로 불러왔습니다.', type: UserProfileDetailStoryJsonDto })
  async getStoryList(@Req() req: any, @Query('userId', ParseIntPipe) userId: number, @Query('offset', ParseIntPipe) offset: number, @Query('limit', ParseIntPipe) limit: number): Promise<UserProfileDetailStoryJsonDto> {
    const stories = await this.userService.getStoryList(req.user.userRecordId, userId, offset, limit);
    return { stories: stories };
  }

  @Get('updateMetaData')
  @ApiOperation({ summary: `업데이트 할 프로필 데이터를 불러옵니다.` })
  @ApiResponse({
    status: 200,
    description: '유저 아이디',
    type: ProfileUpdateMetaDataJsonDto,
  })
  async updateMetaData(@Req() req: any): Promise<ProfileUpdateMetaDataJsonDto> {
    const profileUpdateData = await this.userService.getUpdateMetaData(req.user.userRecordId);
    return { profile: profileUpdateData };
  }

  @Patch('update')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: `자신의 프로필을 수정합니다.` })
  @ApiResponse({
    status: 200,
    description: '유저 아이디',
    schema: {
      type: 'object',
      properties: {
        userId: { type: 'number' },
      },
    },
  })
  async update(@UploadedFile() image: Express.Multer.File, @Req() req: any, @Body(new ValidationPipe({ transform: true })) updateUserDto: UserUpdateDto) {
    const { username, selectedBadgeId } = updateUserDto;
    const userId = await this.userService.update(req.user.userRecordId, { image, username, selectedBadgeId });
    return { userId: userId };
  }

  @Delete('resign')
  @ApiOperation({ summary: `회원 탈퇴` })
  @ApiResponse({ status: 201, description: '회원 탈퇴 되었습니다.' })
  async resign(@Req() req: any, @Body() message: string) {
    return this.userService.resign(req.user.userRecordId, message);
  }

  @Post('follow')
  @ApiOperation({ summary: 'follower Id에 해당하는 유저가 다른 유저를 follow 하는 경우 사용합니다.' })
  @ApiBody({
    type: FollowRequest,
    description: '팔로우할 유저의 ID',
    required: true,
  })
  @ApiResponse({ status: 200, description: 'Follow-Follower 관계가 성공적으로 연결되었습니다.' })
  async addfollow(@Body() followRequest: FollowRequest, @Req() req: any) {
    const transformedDto = plainToClass(FollowRequest, followRequest);
    const followId = transformedDto.followId;
    return await this.userService.addFollowing(followId, req.user.userRecordId);
  }

  @Delete('follow')
  @ApiOperation({ summary: '특정 유저를 언팔로우 합니다.' })
  @ApiBody({
    type: FollowRequest,
    description: '언팔할 유저의 ID',
    required: true,
  })
  @ApiResponse({ status: 200, description: '언팔로우 시도가 정상적으로 처리되었습니다.' })
  async unfollow(@Body() followRequest: FollowRequest, @Req() req: any) {
    const transformedDto = plainToClass(FollowRequest, followRequest);
    const followId = transformedDto.followId;
    return await this.userService.unFollow(followId, req.user.userRecordId);
  }

  @Get('follow')
  @ApiOperation({ summary: '현재 유저의 팔로우 목록을 리턴합니다.' })
  @ApiResponse({ status: 200, description: '현재 유저의 팔로우의 목록입니다', type: UserJsonResponseDto })
  async getMyFollows(@Req() req: any): Promise<UserJsonResponseDto> {
    const currentUserId = req.user.userRecordId;
    const follows = await this.userService.getFollows(currentUserId);
    const transformedFollows = await Promise.all(follows.map(async (follow) => await userEntityToUserObj(follow)));

    return { users: transformedFollows };
  }

  @Get('follower')
  @ApiOperation({ summary: '현재 유저의 팔로워 목록을 리턴합니다.' })
  @ApiResponse({ status: 200, description: '현재 유저의 팔로워들의 목록입니다', type: UserJsonResponseDto })
  async getMyFollowers(@Req() req: any): Promise<UserJsonResponseDto> {
    const currentUserId = req.user.userRecordId;
    const followers = await this.userService.getFollowers(currentUserId);
    const transformedFollowers = await Promise.all(followers.map(async (follower) => await userEntityToUserObj(follower)));

    return { users: transformedFollowers };
  }

  @Get('follow/:id')
  @ApiOperation({ summary: '특정 유저의 팔로잉 목록을 리턴합니다.' })
  @ApiResponse({ status: 200, description: '특정 유저가 팔로우하는 유저들의 목록입니다', type: UserJsonResponseDto })
  async getOtherFollows(@Param('id') userId: number): Promise<UserJsonResponseDto> {
    const follows = await this.userService.getFollows(userId);
    const transformedFollows = await Promise.all(follows.map(async (follow) => await userEntityToUserObj(follow)));

    return { users: transformedFollows };
  }

  @Get('follower/:id')
  @ApiOperation({ summary: '특정 유저의 팔로워 목록을 리턴합니다.' })
  @ApiResponse({ status: 200, description: '특정 유저를 팔로우하는 유저들의 목록입니다', type: UserJsonResponseDto })
  async getOtherFollowers(@Param('id') userId: number): Promise<UserJsonResponseDto> {
    const followers = await this.userService.getFollowers(userId);
    const transformedFollowers = await Promise.all(followers.map(async (follower) => await userEntityToUserObj(follower)));

    return { users: transformedFollowers };
  }

  @Get('recommend')
  @ApiOperation({ summary: '랜덤한 추천 유저 20명을 리턴합니다.' })
  @ApiResponse({ status: 200, description: '추천 유저들을 리턴합니다.', type: UserJsonResponseDto })
  async getRandomUsers(@Param('userId') userId: number): Promise<UserJsonResponseDto> {
    const users = await this.userService.recommendUsers(userId);
    const transformedUsers = await Promise.all(users.map(async (user) => await userEntityToUserObj(user)));
    return { users: transformedUsers };
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
  async addLike(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number): Promise<{ likeCount: number }> {
    const likeCount = await this.userService.like(req.user.userRecordId, storyId);
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
  async unlike(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number): Promise<{ likeCount: number }> {
    const likeCount = await this.userService.unlike(req.user.userRecordId, storyId);
    return { likeCount: likeCount };
  }
}
