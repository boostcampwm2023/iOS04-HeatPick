import { ApiProperty } from '@nestjs/swagger';
import { Place } from '../../../../entities/place.entity';

export class StoryDetailPlaceDataResponseDto {
  @ApiProperty()
  title: string;

  @ApiProperty()
  address: string;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  longitude: number;
}

export const getStoryDetailPlaceDataResponseDto = (place: Place): StoryDetailPlaceDataResponseDto => {
  return {
    title: place.title,
    address: place.address,
    latitude: place.latitude,
    longitude: place.longitude,
  };
};
