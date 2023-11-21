import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { UserService } from './user.service';
import { AddBadgeDto } from './dto/addBadge.dto';

@ApiTags('user')
@Controller('user')
export class UserController {
  constructor(private userService: UserService) {}

  @Post('badge')
  async addBadge(@Body() addBadgeDto: AddBadgeDto) {
    this.userService.addNewBadge(addBadgeDto);
  }
}
