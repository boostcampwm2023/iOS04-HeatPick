import { ApiProperty } from '@nestjs/swagger';
import { IsISO8601, IsNotEmpty, IsObject, IsString } from 'class-validator';

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
  imageList: Array<Express.Multer.File>;

  @ApiProperty({
    example: `커피`,
    description: 'Story Category',
  })
  @IsNotEmpty({ message: 'category 필수입니다.' })
  @IsString()
  category: string;

  @ApiProperty({
    example: `{ lat: 1.2345, lng: 6.7890 }`,
    description: 'Where the story was created',
  })
  @IsNotEmpty({ message: 'place 필수입니다.' })
  @IsObject()
  place: Place;

  @ApiProperty({
    example: `2023-11-14 13:00:00 +0000`,
    description: 'When the story was created',
  })
  @IsNotEmpty({ message: 'date 필수입니다.' })
  @IsISO8601()
  date: Date;

  @ApiProperty({
    example: `3`,
    description: `User's badge`,
  })
  badgeId: number;
}
