import { Body, Controller, Get, Inject, Post, UploadedFile, UploadedFiles, UseFilters, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';
import { ApiBearerAuth, ApiCreatedResponse, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { FileInterceptor } from '@nestjs/platform-express';
import { CustomExceptionFilter } from 'src/exception/custom-exception.filter';

@ApiBearerAuth()
@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: 'Create user' })
  @ApiResponse({
    status: 201,
    description: '새로 발급한 Access 토큰을 string 형태로 반환합니다.',
    schema: {
      type: 'object',
      properties: {
        accessToken: { type: 'string' },
      },
    },
  })
  async signUp(@UploadedFile() image: Express.Multer.File, @Body() registerDto: RegisterDto): Promise<string> {
    const token = await this.authService.signUp(image, registerDto.OAuthToken, registerDto.username);
    return `{ "accessToken": ${token}}`;
  }

  @ApiOperation({ summary: 'Log in' })
  @ApiResponse({
    status: 201,
    description: 'Access Token',
    schema: {
      type: 'object',
      properties: {
        accessToken: { type: 'string' },
      },
    },
  })
  @Post('signin')
  async signIn(@Body() authCredentialDto: AuthCredentialDto): Promise<string> {
    const token = await this.authService.signIn(authCredentialDto.OAuthToken);
    return `{"accessToken": ${token}}`;
  }
}
