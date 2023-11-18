import { Controller } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('place')
@Controller('place')
export class PlaceController {
  constructor() {}
}
