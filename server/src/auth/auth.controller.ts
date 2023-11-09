import { Body, Controller, Get, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  // @Get('signup')
  // async signUp(@Body() authCredentialDto: AuthCredentialDto): Promise<void> {
  //     await this.authService.getId();
  //     return;
  //     //return this.authService.signUp(authCredentialDto);
  // }

  @Post('signin')
  async signIn(@Body() authCredentialDto: AuthCredentialDto): Promise<string> {
    return await this.authService.signIn(authCredentialDto.OAuthToken);
  }
}
