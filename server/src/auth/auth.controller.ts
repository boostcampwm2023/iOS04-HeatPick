import { Body, Controller, Get, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup')
  async signUp(@Body() registerDto: RegisterDto): Promise<string> {
    return this.authService.signUp(
      registerDto.OAuthToken,
      registerDto.username,
    );
  }

  @Post('signin')
  async signIn(@Body() authCredentialDto: AuthCredentialDto): Promise<string> {
    return await this.authService.signIn(authCredentialDto.OAuthToken);
  }
}
