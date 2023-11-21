import { Body, Controller, Get, Post, Query } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/addBadge.dto';

@ApiTags('user')
@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}

  @Post('badge')
  @ApiOperation({ summary: 'Add a new badge to a user' })
  @ApiResponse({ status: 201, description: 'Badge가 성공적으로 추가되었습니다.' })
  async addBadge(@Body() addBadgeDto: AddBadgeDto) {
    return this.userService.addNewBadge(addBadgeDto);
  }

  @Get('profile')
  @ApiOperation({ summary: 'Get a profile' })
  @ApiResponse({ status: 201, description: 'Profile을 성공적으로 불러왔습니다.' })
  async getProfile(@Query() userId: number) {
    return this.userService.getProfile(userId);
  }
}
