import { extname } from 'path';
import { promisify } from 'util';
import * as fs from 'fs';
import { Readable } from 'stream';

// eslint-disable-next-line @typescript-eslint/no-var-requires
const pipeline = promisify(require('stream').pipeline);

export const saveImage = async (path: string, imageBuffer: Buffer): Promise<string> => {
  const folderPath = path;
  //const folderPath = '../../uploads';
  const fileName = generateRandomFileName();

  const readableImage = new Readable();
  readableImage.push(imageBuffer);
  readableImage.push(null);

  await pipeline(readableImage, fs.createWriteStream(`${folderPath}/${fileName}`));
  // 저장된 이미지의 경로 반환
  return `${folderPath}/${fileName}`;
};

const generateRandomFileName = (): string => {
  const randomName = Array(32)
    .fill(null)
    .map(() => Math.round(Math.random() * 16).toString(16))
    .join('');
  return `${randomName}${extname('image.png')}`;
};
