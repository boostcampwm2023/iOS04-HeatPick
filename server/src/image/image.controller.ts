import { Controller, Get, Param } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ImageService } from './image.service';

@Controller('image')
export class ImageController {
  constructor(private imageService: ImageService) {}

  @Get(':path')
  @ApiOperation({ summary: 'Get Image' })
  @ApiResponse({ status: 200, description: 'Profile Image or Story Image' })
  async requestImage(@Param('path') path: string): Promise<Buffer> {
    return await this.imageService.readImage(path);
  }
}
