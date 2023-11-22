import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class UserUpdateDto {
  @ApiProperty({ example: 'my name', description: 'updated user name' })
  @IsNotEmpty({ message: 'username 필수입니다' })
  @IsString()
  username: string;

  @ApiProperty({ example: '미정', description: '미정' })
  @IsNotEmpty({ message: 'mainBadge 필수입니다' })
  @IsString()
  mainBadge: string;
}
