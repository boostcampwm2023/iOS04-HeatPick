import { Module } from '@nestjs/common';
import { DatabaseModule } from 'src/db/database.module';
import { PlaceProvider } from './place.provider';
import { PlaceService } from './place.service';
import { PlaceController } from './place.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [PlaceController],
  providers: [...PlaceProvider, PlaceService],
  exports: [PlaceService],
})
export class PlaceModule {}
