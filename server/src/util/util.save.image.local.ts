import { generateRandomFileName } from './util.generate.randomFileName';
import { promisify } from 'util';
import * as fs from 'fs';
import { Readable } from 'stream';

// eslint-disable-next-line @typescript-eslint/no-var-requires
const pipeline = promisify(require('stream').pipeline);

export const saveImageToLocal = async (path: string, imageBuffer: Buffer): Promise<string> => {
  const folderPath = path;
  const fileName = generateRandomFileName();

  const readableImage = new Readable();
  readableImage.push(imageBuffer);
  readableImage.push(null);

  await pipeline(readableImage, fs.createWriteStream(`${folderPath}/${fileName}`));
  // 저장된 이미지의 경로 반환
  return `${folderPath}/${fileName}`;
};
