import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { User } from 'src/entities/user.entity';
import { JwtAuthGuard } from './jwt.guard';

@ApiBearerAuth()
@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup')
  @ApiOperation({ summary: 'Create user' })
  @ApiResponse({ status: 200, description: 'Access Token' })
  async signUp(@Body() registerDto: RegisterDto): Promise<string> {
    return this.authService.signUp(
      registerDto.OAuthToken,
      registerDto.username,
    );
  }

  @ApiResponse({
    status: 200,
    description: 'Access Token',
    type: User,
  })
  @Post('signin')
  async signIn(@Body() authCredentialDto: AuthCredentialDto): Promise<string> {
    return await this.authService.signIn(authCredentialDto.OAuthToken);
  }
}
