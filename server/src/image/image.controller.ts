import { Controller, Get, Param } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('image')
export class ImageController {
  constructor() {}

  @Get('profile/:path')
  @ApiOperation({ summary: 'Get Profile Image' })
  @ApiResponse({ status: 200, description: 'profileImage' })
  async getProfileImage(@Param('path') path: string) {
    return
  }

}