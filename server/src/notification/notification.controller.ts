import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { NotificationService } from './notification.service';
import { SaveTokenRequestDto } from './dto/save-token-request.dto';
import { JwtAuthGuard } from '../auth/jwt.guard';

@UseGuards(JwtAuthGuard)
@ApiTags('notification')
@Controller('notification')
export class NotificationController {
  constructor(private notificationService: NotificationService) {}

  @Post('save-fcm-token')
  @ApiOperation({ summary: 'fcm 토큰을 저장' })
  @ApiResponse({
    status: 201,
    description: 'fcm 토큰을 저장합니다.',
  })
  async saveFcmToken(@Req() req: any, @Body() saveTokenRequestDto: SaveTokenRequestDto) {
    const { fcmToken } = saveTokenRequestDto;
    const message = await this.notificationService.saveFcmToken(req.user.userRecordId, fcmToken);
    return { message: message };
  }
}
