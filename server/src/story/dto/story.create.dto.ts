import { ApiProperty } from '@nestjs/swagger';
import { IsISO8601, IsNotEmpty, IsObject, IsString } from 'class-validator';
import { Transform } from 'class-transformer';

type Place = {
  lat: number;
  lng: number;
};

export class CreateStoryDto {
  @ApiProperty({ example: 'my Story', description: 'Story Title' })
  @IsNotEmpty({ message: 'title 필수입니다.' })
  @IsString()
  title: string;

  @ApiProperty({ example: 'my Story content', description: 'Story Content' })
  @IsNotEmpty({ message: 'content 필수입니다.' })
  @IsString()
  content: string;

  @ApiProperty({
    example: '[...(stringBuffer)]',
    description: 'ImageList in Story',
  })
  images: Array<Express.Multer.File>;

  @ApiProperty({
    example: `커피`,
    description: 'Story Category',
  })
  @IsNotEmpty({ message: 'category 필수입니다.' })
  @IsString()
  category: string;

  @ApiProperty({
    example: `{ latitude: 1.2345, longitude: 6.7890, title: '장소 이름', address: '주소명' }`,
    description: 'Where the story was created',
  })
  @IsNotEmpty({ message: 'place 필수입니다.' })
  @Transform(({ value }): object => JSON.parse(value))
  place: Place;

  @ApiProperty({
    example: `"2023-11-20T14:30:00Z"`,
    description: 'When the story was created',
  })
  @IsNotEmpty({ message: 'date 필수입니다.' })
  @IsISO8601()
  date: string;

  @ApiProperty({
    example: `3`,
    description: `User's badge`,
  })
  badgeId: number;
}
