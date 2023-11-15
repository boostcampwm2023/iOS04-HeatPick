import { Body, Controller, Get, Inject, Post, UploadedFile, UploadedFiles, UseFilters, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';
import { ApiBearerAuth, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { saveImage } from 'src/util/story.util.saveImage';
import { FileInterceptor } from '@nestjs/platform-express';
import { HttpExceptionFilter } from 'src/exception/http-exception.filter';

@ApiBearerAuth()
@ApiTags('auth')
@UseFilters(HttpExceptionFilter)
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: 'Create user' })
  @ApiResponse({ status: 201, description: 'Access Token' })
  async signUp(@UploadedFile() image: Express.Multer.File, @Body() registerDto: RegisterDto): Promise<string> {
    let savedImagePaths = '';
    const token = await this.authService.signUp(registerDto.OAuthToken, registerDto.username, savedImagePaths);
    if (image) savedImagePaths = await saveImage('./images/profile', image.buffer);
    return `{ accessToken: ${token}}`;
  }

  @ApiOperation({ summary: 'Log in' })
  @ApiResponse({ status: 201, description: 'Access Token' })
  @Post('signin')
  async signIn(@Body() authCredentialDto: AuthCredentialDto): Promise<string> {
    const token = await this.authService.signIn(authCredentialDto.OAuthToken);
    return `{accessToken: ${token}}`;
  }
}
