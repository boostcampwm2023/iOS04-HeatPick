import { ApiProperty } from '@nestjs/swagger';

export class StoryDetailPlaceDataDto {
  @ApiProperty()
  title: string;

  @ApiProperty()
  address: string;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  longitude: number;
}
