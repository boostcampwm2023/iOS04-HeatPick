import { ApiProperty } from '@nestjs/swagger';

export class CategoryDto {
  @ApiProperty({ description: '카테고리 ID' })
  categoryId: number;

  @ApiProperty({ description: '카테고리의 이름' })
  categoryName: string;
}

export class CategoryJsonDto {
  @ApiProperty({ description: 'JSON 형식으로 category 정보를 리턴', isArray: true })
  categories: CategoryDto[];
}
