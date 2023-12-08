import { Injectable, Logger } from '@nestjs/common';
import { FcmTokenSaveFailedException } from '../exception/custom.exception/fcm-token-save-failed.exception';
import {
  FcmSendNotificationFailedException
} from '../exception/custom.exception/fcm-send-notification-failed.exception';

@Injectable()
export class NotificationService {
  private BASE_URL: string = 'http://175.45.201.252:3000';
  private logger = new Logger('http');

  public async saveFcmToken(userId: number, fcmToken: string) {
    const api_url = `${this.BASE_URL}/save-token`;
    try {
      const response = await fetch(api_url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          userId: userId,
          token: fcmToken,
        }),
      });

      return response.text();
    } catch (error) {
      throw new FcmTokenSaveFailedException();
    }
  }

  public async sendFcmNotification(userId: number, title: string, body: string) {
    const api_url = `${this.BASE_URL}/send-notification`;
    try {
      const response = await fetch(api_url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          userId: userId,
          title: title,
          body: body,
        }),
      });

      this.logger.log(response.text());
      return response.text();
    } catch (error) {
      throw new FcmSendNotificationFailedException();
    }
  }
}
