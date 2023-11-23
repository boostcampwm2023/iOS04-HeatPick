import { Controller, Get, Query, Res } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ImageService } from './image.service';
import { Response } from 'express';

@Controller('image')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get('story')
  @Header('content-type', 'image/png')
  @ApiOperation({ summary: 'Get Story Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image', type: 'image/png' })
  async requestStoryImage(@Query('name') name: string, @Res() res: Response) {
    const storyImagePath = './images/story';
    res.set('Content-Type', 'image/png');
    res.send(await this.imageService.readImage(`${storyImagePath}/${name}`));
  }

  @Get('profile')
  @ApiOperation({ summary: 'Get Profile Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image' })
  async requestProfileImage(@Query('name') name: string, @Res() res: Response) {
    const storyImagePath = './images/profile';
    res.set('Content-Type', 'image/png');
    res.send(await this.imageService.readImage(`${storyImagePath}/${name}`));
  }
}
