import { Body, Controller, Post, Put } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/addBadge.dto';
import { AddBadgeExpDto } from './dto/addBadgeExp.dto';
import { plainToClass } from 'class-transformer';

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
}
