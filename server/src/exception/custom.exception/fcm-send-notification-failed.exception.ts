import { HttpException } from '@nestjs/common';

export class FcmSendNotificationFailedException extends HttpException {
  constructor() {
    super('FCM 알림 전송에 실패했습니다.', 503);
  }
}
