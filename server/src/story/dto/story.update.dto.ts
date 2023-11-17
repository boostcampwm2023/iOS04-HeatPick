import { ApiProperty } from '@nestjs/swagger';
import { IsArray, IsNotEmpty, IsNumber, IsString } from 'class-validator';
import { Transform } from 'class-transformer';

type Place = {
  lat: number;
  lng: number;
};

export class UpdateStoryDto {
  @ApiProperty({ example: 1, description: 'Story Id' })
  @IsNotEmpty({ message: 'storyId는 필수입니다.' })
  @Transform(({ value }): number => parseInt(value, 10))
  @IsNumber()
  storyId: number;

  @ApiProperty({ example: 'my Story', description: 'Story Title' })
  @IsString()
  title: string;

  @ApiProperty({ example: 'my Story content', description: 'Story Content' })
  @IsString()
  content: string;

  @ApiProperty({
    example: '[...(stringBuffer)]',
    description: 'ImageList in Story',
  })
  imageList: Array<Express.Multer.File>;

  @ApiProperty({
    example: `['coffee', 'travel']`,
    description: 'Story Category',
  })
  category: string[];

  @ApiProperty({
    example: `{ lat: 1.2345, lng: 6.7890 }`,
    description: 'Where the story was created',
  })
  place: Place;

  @ApiProperty({
    example: `2023-11-14 13:00:00 +0000`,
    description: 'When the story was created',
  })
  date: Date;

  @ApiProperty({
    example: `3`,
    description: `User's badge`,
  })
  badgeId: number;
}
