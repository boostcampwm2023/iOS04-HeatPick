import { ApiProperty } from '@nestjs/swagger';

export class AuthCredentialDto {
  @ApiProperty({ example: 'dsfAVBS3423ASD53245', description: 'OAuth Token' })
  OAuthToken: string;
}
