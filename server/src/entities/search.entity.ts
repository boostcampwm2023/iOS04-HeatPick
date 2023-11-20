import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class SearchHistory {
  @PrimaryGeneratedColumn()
  @ApiProperty({ description: '검색 기록을 식별하기 위한 id' })
  id: number;

  @Column()
  @ApiProperty({ description: '검색 기록의 내용' })
  content: string;

  @Column()
  @ApiProperty({ description: '해당 검색어가 몇 번 검색되었는지 저장하고 있는 변수' })
  count: number;
}
