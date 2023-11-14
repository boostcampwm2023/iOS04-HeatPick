import { ApiProperty } from '@nestjs/swagger';

type Place = {
  lat: number;
  lng: number;
};

export class CreateStoryDto {
  @ApiProperty({ example: 'my Story', description: 'Story Title' })
  title: string;

  @ApiProperty({ example: 'my Story content', description: 'Story Content' })
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
