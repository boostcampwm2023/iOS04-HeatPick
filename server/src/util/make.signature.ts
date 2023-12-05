/*
https://code.google.com/archive/p/crypto-js/
https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/crypto-js/CryptoJS%20v3.1.2.zip
*/

/*
CryptoJS v3.1.2
code.google.com/p/crypto-js
(c) 2009-2013 by Jeff Mott. All rights reserved.
code.google.com/p/crypto-js/wiki/License
*/
import * as CryptoJS from 'crypto-js';
import * as dotenv from 'dotenv';

dotenv.config();

export function makeSignature() {
  var currentDate = new Date();

  var currentDate = new Date();
  var timestamp = Math.floor(currentDate.getTime());
  var space = ' ';
  var newLine = '\n';
  var method = 'GET';
  var url = `https://cloudsearch.apigw.ntruss.com/CloudSearch/real/v1/domain/heatpick/document/search/autocomplete?query=서울?type=term`; // url (include query string)
  console.log(url);
  var timestamp = timestamp;
  var accessKey = process.env.NCLOUD_ACCESS_KEY;
  var secretKey = process.env.NCLOUD_SECRET_KEY;

  var hmac = CryptoJS.HmacSHA256(`${method}${space}${url}${newLine}${timestamp}${newLine}${accessKey}`, secretKey);

  var hash = CryptoJS.enc.Base64.stringify(hmac);

  return [hash, accessKey, timestamp];
}
