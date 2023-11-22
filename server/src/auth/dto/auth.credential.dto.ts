import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class AuthCredentialDto {
  @ApiProperty({ example: 'dsfAVBS3423ASD53245', description: 'OAuth Token' })
  @IsString()
  OAuthToken: string;
}
