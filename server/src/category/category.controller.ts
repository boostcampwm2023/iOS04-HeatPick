import { Body, Controller, Get, Post, UploadedFile } from '@nestjs/common';
import { ApiBearerAuth, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CategoryService } from './category.service';
import { CategoryJsonDto } from './dto/response/get.category.return.dto';

@ApiBearerAuth()
@ApiTags('category')
@Controller('category')
export class CategoryController {
  constructor(private categoryService: CategoryService) {}

  @Get('')
  @ApiOperation({ summary: '모든 카테고리를 return' })
  @ApiResponse({
    status: 201,
    description: '모든 카테고리 정보를 리턴합니다.',
  })
  async getCategories(): Promise<CategoryJsonDto> {
    const categories = await this.categoryService.getCategoryList();
    return { categories: categories };
  }
}
