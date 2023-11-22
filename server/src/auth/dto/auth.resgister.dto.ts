import { ApiProperty } from '@nestjs/swagger/dist';
import { IsString } from 'class-validator';

export class RegisterDto {
  @ApiProperty({ example: 'dsfAVBS3423ASD53245', description: 'OAuth Token' })
  @IsString()
  OAuthToken: string;

  @ApiProperty({ example: 'boostcamp', description: 'user nickname' })
  @IsString()
  username: string;
}
