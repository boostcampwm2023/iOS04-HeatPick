import { Inject, Injectable } from '@nestjs/common';
import { Place } from 'src/entities/place.entity';
import { graphemeSeperation } from 'src/util/util.graphmeModify';
import { In, Repository } from 'typeorm';
import { PlaceJasoTrie } from './../search/trie/placeTrie';

@Injectable()
export class PlaceService {
  constructor(
    @Inject('PLACE_REPOSITORY')
    private placeRepository: Repository<Place>,
    private placeJasoTrie: PlaceJasoTrie,
  ) {
    this.placeRepository.find().then((everyPlace) => {
      everyPlace.forEach((place) => this.placeJasoTrie.insert(graphemeSeperation(place.title), place.placeId));
    });
  }

  async getPlaceFromTrie(seperatedStatement: string[]) {
    const ids = this.placeJasoTrie.search(seperatedStatement);
    const places = await this.placeRepository.find({ where: { placeId: In(ids) } });
    return places;
  }
}
