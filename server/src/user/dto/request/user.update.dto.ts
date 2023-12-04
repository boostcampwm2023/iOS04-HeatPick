import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';
import { Transform } from 'class-transformer';

export class UserUpdateDto {
  @ApiProperty({ example: 'my name', description: 'updated user name' })
  @IsNotEmpty({ message: 'username 필수입니다' })
  @IsString()
  username: string;

  @ApiProperty({ example: 3, description: 'main badge Id' })
  @IsNotEmpty({ message: 'mainBadgeId 필수입니다' })
  @Transform(({ value }): number => parseInt(value, 10))
  @IsNumber()
  selectedBadgeId: number;

  @ApiProperty()
  image: Express.Multer.File;
}
