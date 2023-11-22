import { Injectable } from '@nestjs/common';
import axios from 'axios';

@Injectable()
export class SlackService {
  async sendErrorNotification(error: any) {
    const webhookUrl = process.env.SLACK_WEBHOOK_URL;

    if (!webhookUrl) {
      console.error('Slack Webhook URL is not configured.');
      return;
    }

    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    const stackTrace = error instanceof Error ? error.stack : 'No stack trace available';
    let specificMessage = 'N/A';
    if (error.response && error.response.message) {
      specificMessage = error.response.message;
    }

    try {
      await axios.post(webhookUrl, {
        text: `:fire: *Error occurred* :fire:\n\n*Message:* ${errorMessage}\n\n*Detail Message* :${specificMessage} \n\n*Stack Trace:* \`\`\`${stackTrace}\`\`\``,
      });
    } catch (error) {
      console.error('Error sending message to Slack:', error.message);
    }
  }
}
