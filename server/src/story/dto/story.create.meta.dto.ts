import { ApiProperty } from '@nestjs/swagger';

export class CreateStoryMetaDto {
  @ApiProperty({ example: `[ { categoryId: 10, categoryName: '카페' }, ]`, description: '카테고리 리스트' })
  categoryList: { categoryId: number; categoryName: string }[];

  @ApiProperty({ example: `[ badgeId: 3; badgeName: '카페인 중독', ]`, description: '뱃지 리스트' })
  badgeList: { badgeId: number; badgeName: string }[];
}
