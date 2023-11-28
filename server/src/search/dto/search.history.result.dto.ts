import { ApiProperty } from '@nestjs/swagger';

export class SearchHistoryResultDto {
  @ApiProperty({ description: '스토리 객체의 배열', type: String, isArray: true })
  histories: string[];
}
