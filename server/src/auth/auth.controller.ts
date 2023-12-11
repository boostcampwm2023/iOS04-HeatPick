import { Body, Controller, Get, Inject, Post, Query, UploadedFile, UploadedFiles, UseFilters, UseGuards, UseInterceptors } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthCredentialDto } from './dto/auth.credential.dto';
import { RegisterDto } from './dto/auth.resgister.dto';
import { ApiBearerAuth, ApiCreatedResponse, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { FileInterceptor } from '@nestjs/platform-express';

@ApiBearerAuth()
@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('signup/github')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: '깃허브 토큰으로 Create user' })
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
  async githubSignUp(@UploadedFile() image: Express.Multer.File, @Body() registerDto: RegisterDto) {
    const token = await this.authService.signUp(image, registerDto.OAuthToken, registerDto.username, 0);
    return { accessToken: token };
  }

  @Post('signup/naver')
  @UseInterceptors(FileInterceptor('image'))
  @ApiOperation({ summary: '네이버 토큰으로 Create user' })
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
  async naverSignUp(@UploadedFile() image: Express.Multer.File, @Body() registerDto: RegisterDto) {
    const token = await this.authService.signUp(image, registerDto.OAuthToken, registerDto.username, 1);
    return { accessToken: token };
  }

  @ApiOperation({ summary: 'Github Log in' })
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
  @Post('signin/github')
  async signIn(@Body() authCredentialDto: AuthCredentialDto) {
    const token = await this.authService.signIn(authCredentialDto.OAuthToken, 0);
    return { accessToken: token };
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
  @Post('signin/naver')
  async naverSignIn(@Body() authCredentialDto: AuthCredentialDto) {
    const token = await this.authService.signIn(authCredentialDto.OAuthToken, 1);
    return { accessToken: token };
  }

  @ApiOperation({ summary: ' Nickname 중복을 체크합니다.' })
  @Get('check')
  async checkDuplicatedGithub(@Body('nickname') nickname: string) {
    await this.authService.checkDuplicated(nickname);
  }
}
