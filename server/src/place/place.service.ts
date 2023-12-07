import { Inject, Injectable } from '@nestjs/common';
import { Place } from 'src/entities/place.entity';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { In, Repository } from 'typeorm';
import { LocationDTO } from './dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
import { Cron, CronExpression } from '@nestjs/schedule';
import { Transactional } from 'typeorm-transactional';

@Injectable()
export class PlaceService {
  constructor(
    @Inject('PLACE_REPOSITORY')
    private placeRepository: Repository<Place>,
  ) {}

  @Transactional()
  async getPlaceByPosition(locationDto: LocationDTO) {
    const userLatitude = locationDto.latitude;
    const userLongitude = locationDto.longitude;
    const radius = 2;

    const allPlaces = await this.placeRepository.find();
    const places = allPlaces.filter((place) => {
      const placeDistance = calculateDistance(userLatitude, userLongitude, place.latitude, place.longitude);
      return placeDistance <= radius;
    });

    return places;
  }
}
