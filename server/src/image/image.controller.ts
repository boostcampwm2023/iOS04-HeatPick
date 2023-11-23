import { Controller, Get, Header, Param, Query } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ImageService } from './image.service';

@Controller('image')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get('story')
  @Header('content-type', 'image/png')
  @ApiOperation({ summary: 'Get Story Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image' })
  async requestStoryImage(@Query('name') name: string): Promise<Buffer> {
    const storyImagePath = './images/story';
    return await this.imageService.readImage(`${storyImagePath}/${name}`);
  }

  @Get('profile')
  @ApiOperation({ summary: 'Get Profile Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image' })
  async requestProfileImage(@Query('name') name: string): Promise<Buffer> {
    const storyImagePath = './images/profile';
    return await this.imageService.readImage(`${storyImagePath}/${name}`);
  }
}
