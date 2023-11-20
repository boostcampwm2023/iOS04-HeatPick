import { DataSource } from 'typeorm';
import { Place } from './../entities/place.entity';

export const PlaceProvider = [
  {
    provide: 'PLACE_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Place),
    inject: ['DATA_SOURCE'],
  },
];
