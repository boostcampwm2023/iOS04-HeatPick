import { Body, Controller, Get, Patch, Post, Query, Headers, UseInterceptors, UploadedFile, Delete, Put } from '@nestjs/common';

import { ApiBody, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/addBadge.dto';
import { AddBadgeExpDto } from './dto/addBadgeExp.dto';
import { plainToClass } from 'class-transformer';
import { userProfileDetailDataType } from './type/user.profile.detail.data.type';
import { Story } from '../entities/story.entity';
import { JwtService } from '@nestjs/jwt';
import { UserUpdateDto } from './dto/user.update.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { FollowRequest } from './dto/follow.reqeust.dto';

@ApiTags('user')
@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}

  @Post('badge')
  @ApiOperation({ summary: '유제 객체에 새로운 뱃지를 추가합니다.' })
  @ApiResponse({ status: 200, description: 'Badge가 성공적으로 추가되었습니다.' })
  async addBadge(@Body() addBadgeDto: AddBadgeDto) {
    return this.userService.addNewBadge(addBadgeDto);
  }

  @Get('profile')
  @ApiOperation({ summary: 'Get a profile' })
  @ApiResponse({ status: 201, description: 'Profile을 성공적으로 불러왔습니다.', type: Promise<userProfileDetailDataType> })
  async getProfile(@Query() userId: number): Promise<userProfileDetailDataType> {
    return this.userService.getProfile(userId);
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
  @ApiOperation({ summary: `Get All user's storyList` })
  @ApiResponse({ status: 201, description: '사용자의 StoryList를 성공적으로 불러왔습니다.', type: [Story] })
  async getStoryList(@Query() userId: number): Promise<Story[]> {
    return this.userService.getStoryList(userId);
  }

  @Patch('update')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: `Update user's info` })
  @ApiResponse({ status: 201, description: '사용자의 정보를 성공적으로 수정했습니다.' })
  async update(@Headers('accessToken') accessToken: string, @UploadedFile() image: Express.Multer.File, @Body() updateUserDto: UserUpdateDto) {
    const { username, mainBadge } = updateUserDto;
    return this.userService.update(accessToken, image, { username, mainBadge });
  }

  @Delete('resign')
  @ApiOperation({ summary: `resign user` })
  @ApiResponse({ status: 201, description: '회원 탈퇴 되었습니다.' })
  async resign(@Headers('accessToken') accessToken: string, @Body() message: string) {
    return this.userService.resign(accessToken, message);
  }

  @Post('follow')
  @ApiOperation({ summary: 'follower Id에 해당하는 유저가 다른 유저를 follow 하는 경우입니다.' })
  @ApiBody({
    type: FollowRequest,
    description: '팔로우할 유저의 ID',
    required: true,
  })
  @ApiResponse({ status: 200, description: 'Follow-Follower 관계가 성공적으로 연결되었습니다.' })
  async addfollow(@Body() followId: number) {
    return this.userService.addFollowing(followId, 4);
  }
}
