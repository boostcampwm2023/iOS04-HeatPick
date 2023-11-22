import { Injectable } from '@nestjs/common';
import axios from 'axios';

@Injectable()
export class SlackService {
  async sendErrorNotification(message: string) {
    const webhookUrl = process.env.SLACK_WEBHOOK_URL;

    if (!webhookUrl) {
      console.error('Slack Webhook URL is not configured.');
      return;
    }

    try {
      await axios.post(webhookUrl, { text: `Error: ${message}` });
    } catch (error) {
      console.error('Error sending message to Slack:', error.message);
    }
  }
}
