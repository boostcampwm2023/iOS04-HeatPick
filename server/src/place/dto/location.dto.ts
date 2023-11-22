import { ApiProperty } from '@nestjs/swagger';
import { Transform, TransformFnParams } from 'class-transformer';
import { IsNumber } from 'class-validator';

export class LocationDTO {
  @ApiProperty({ example: '40.0', description: '위치 정보의 위도에 해당합니다.' })
  @Transform(({ value }: TransformFnParams) => parseFloat(value))
  @IsNumber()
  latitude: number;

  @ApiProperty({ example: '50.5', description: '위치 정보의 경도에 해당합니다.' })
  @Transform(({ value }: TransformFnParams) => parseFloat(value))
  @IsNumber()
  longitude: number;
}
