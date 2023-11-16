import { Controller, Get, Param, Query } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ImageService } from './image.service';

@Controller('image')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get()
  @ApiOperation({ summary: 'Get Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image' })
  async requestImage(@Query('path') path: string): Promise<Buffer> {
    return await this.imageService.readImage(path);
  }
}
