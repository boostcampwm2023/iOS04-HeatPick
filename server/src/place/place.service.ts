import { Inject, Injectable } from '@nestjs/common';
import { Place } from 'src/entities/place.entity';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { In, Repository } from 'typeorm';
import { PlaceJasoTrie } from './../search/trie/placeTrie';
import { LocationDTO } from './dto/location.dto';
import { calculateDistance } from 'src/util/util.haversine';
import { Cron, CronExpression } from '@nestjs/schedule';

@Injectable()
export class PlaceService {
  constructor(
    @Inject('PLACE_REPOSITORY')
    private placeRepository: Repository<Place>,
    private placeJasoTrie: PlaceJasoTrie,
  ) {
    this.loadPlaceTrie();
  }

  @Cron(CronExpression.EVERY_HOUR)
  loadPlaceTrie() {
    this.placeRepository.find().then((everyPlace) => {
      everyPlace.forEach((place) => this.placeJasoTrie.insert(graphemeSeperation(place.title), place.placeId));
    });
  }

  async getPlaceFromTrie(seperatedStatement: string[]) {
    const ids = this.placeJasoTrie.search(seperatedStatement);
    const places = await this.placeRepository.find({ where: { placeId: In(ids) } });
    return places;
  }

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
