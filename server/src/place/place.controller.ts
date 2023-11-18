import { Controller, Get, Inject, Query } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { PlaceService } from './place.service';
import { LocationDTO } from './dto/location.dto';

@ApiTags('place')
@Controller('place')
export class PlaceController {
  constructor(@Inject(PlaceService) private placeService: PlaceService) {}

  @Get('')
  @ApiOperation({ summary: '전송된 위치를 기반으로, 범위에 포함되는 모든 장소를 리턴합니다.' })
  @ApiResponse({ status: 201 })
  async getPlaceByPosition(@Query() locationDTO: LocationDTO) {}
}
