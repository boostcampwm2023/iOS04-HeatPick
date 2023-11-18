import { Controller, Get, Inject, Query } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { PlaceService } from './place.service';
import { LocationDTO } from './dto/location.dto';
import { Place } from 'src/entities/place.entity';

@ApiTags('place')
@Controller('place')
export class PlaceController {
  constructor(@Inject(PlaceService) private placeService: PlaceService) {}

  @Get('')
  @ApiOperation({ summary: '전송된 위치를 기반으로, 범위에 포함되는 모든 장소를 리턴합니다.' })
  @ApiResponse({
    status: 201,
    description: '쿼리 파라미터로 넘어온 위도와 경도를 바탕으로 반경 2km내의 장소를 리턴합니다.',
    type: [Place],
  })
  async getPlaceByPosition(@Query() locationDto: LocationDTO) {
    return await this.placeService.getPlaceByPosition(locationDto);
  }
}
