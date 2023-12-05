import * as dotenv from 'dotenv';
import * as crypto from 'crypto';
dotenv.config();

export function makeSignature() {
  var timestamp = Date.now().toString();
  const message = [];

  var space = ' ';
  var newLine = '\n';
  var method = 'POST';
  var url = `/CloudSearch/real/v1/domain/heatpick/document/search/autocomplete`; // url (include query string)
  var accessKey = process.env.NCLOUD_ACCESS_KEY;
  var secretKey = process.env.NCLOUD_SECRET_KEY;

  var hmac = crypto.createHmac('sha256', secretKey);

  message.push(method);
  message.push(space);
  message.push(url);
  message.push(newLine);
  message.push(timestamp);
  message.push(newLine);
  message.push(accessKey);
  const signature = hmac.update(message.join('')).digest('base64');
  return [signature.toString(), accessKey, timestamp];
}
