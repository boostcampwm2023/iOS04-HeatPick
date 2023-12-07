import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class SaveTokenRequestDto {
  @ApiProperty({ example: 'token-string', description: 'FCM 토큰' })
  @IsNotEmpty({ message: 'FCM 토큰 필수입니다.' })
  @IsString()
  fcmToken: string;
}
