import { HttpException } from '@nestjs/common';

export class FcmTokenSaveFailedException extends HttpException {
  constructor() {
    super('FCM Token 저장에 실패했습니다.', 503);
  }
}
