import { Body, Controller, Get, Patch, Post, Query, Headers, UseInterceptors, UploadedFile, Delete, Put, ParseIntPipe, ValidationPipe } from '@nestjs/common';

import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/addBadge.dto';
import { AddBadgeExpDto } from './dto/addBadgeExp.dto';
import { plainToClass } from 'class-transformer';
import { Story } from '../entities/story.entity';
import { UserUpdateDto } from './dto/user.update.dto';
import { FileInterceptor } from '@nestjs/platform-express';
import { UserProfileDetailDataDto } from './dto/user.profile.detail.data.dto';

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
  @ApiResponse({ status: 201, description: 'Profile을 성공적으로 불러왔습니다.', type: UserProfileDetailDataDto })
  async getProfile(@Query('userId', ParseIntPipe) userId: number): Promise<UserProfileDetailDataDto> {
    return this.userService.getProfile(undefined, userId);
  }

  @Get('myProfile')
  @ApiOperation({ summary: 'Get my profile' })
  @ApiResponse({ status: 201, description: 'My Profile을 성공적으로 불러왔습니다.', type: UserProfileDetailDataDto })
  async getMyProfile(@Headers('accessToken') accessToken: string): Promise<UserProfileDetailDataDto> {
    return this.userService.getProfile(accessToken, undefined);
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
  async getStoryList(@Query('userId', ParseIntPipe) userId: number): Promise<Story[]> {
    return this.userService.getStoryList(userId);
  }

  @Patch('update')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: `Update user's info` })
  @ApiResponse({ status: 201, description: '사용자의 정보를 성공적으로 수정했습니다.' })
  async update(@UploadedFile() image: Express.Multer.File, @Headers('accessToken') accessToken: string, @Body(new ValidationPipe({ transform: true })) updateUserDto: UserUpdateDto) {
    const { username, mainBadgeId } = updateUserDto;
    return this.userService.update(accessToken, image, { username, mainBadgeId });
  }

  @Delete('resign')
  @ApiOperation({ summary: `resign user` })
  @ApiResponse({ status: 201, description: '회원 탈퇴 되었습니다.' })
  async resign(@Headers('accessToken') accessToken: string, @Body() message: string) {
    return this.userService.resign(accessToken, message);
  }
}
