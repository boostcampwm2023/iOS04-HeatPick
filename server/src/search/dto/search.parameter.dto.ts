import { ApiProperty } from '@nestjs/swagger';

export class SearchParameterDto {
  @ApiProperty({
    required: false,
    description: '검색어',
  })
  searchText: string;
  @ApiProperty({
    required: false,
    description: '카테고리 ID',
  })
  categoryId: number;
}
