import { ApiProperty } from '@nestjs/swagger/dist';

export class RegisterDto {
  @ApiProperty({ example: 'dsfAVBS3423ASD53245', description: 'OAuth Token' })
  OAuthToken: string;

  @ApiProperty({ example: 'boostcamp', description: 'user nickname' })
  username: string;
}
