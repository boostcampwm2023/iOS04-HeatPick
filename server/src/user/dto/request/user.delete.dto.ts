import { ApiProperty } from '@nestjs/swagger';

export class UserDeleteDto {
  @ApiProperty()
  message: string;
}
