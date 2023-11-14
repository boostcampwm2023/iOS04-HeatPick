import { Body, Controller, Get, Post, UploadedFile, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';
import { ApiBearerAuth, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { User } from 'src/entities/user.entity';
import { saveImage } from 'src/util/story.util.saveImage';
import { FileInterceptor } from '@nestjs/platform-express';

@ApiBearerAuth()
@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: 'Create user' })
  @ApiResponse({ status: 200, description: 'Access Token' })
  async signUp(@UploadedFile() image: Express.Multer.File, @Body() registerDto: RegisterDto): Promise<string> {
    let savedImagePaths = '';
    if (image) savedImagePaths = await saveImage('./images/profile', image.buffer);
    return this.authService.signUp(registerDto.OAuthToken, registerDto.username, savedImagePaths);
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
