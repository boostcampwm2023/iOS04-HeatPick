import { Injectable } from '@nestjs/common';
import { FcmTokenSaveFailedException } from '../exception/custom.exception/fcm-token-save-failed.exception';

@Injectable()
export class NotificationService {
  public async saveFcmToken(userId: number, fcmToken: string) {
    const api_url = 'http://175.45.201.252:3000/save-token';
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
}
