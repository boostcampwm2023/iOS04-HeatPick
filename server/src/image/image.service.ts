import { Injectable } from '@nestjs/common';
import { generateRandomFileName } from '../util/util.generate.randomFileName';
import { promisify } from 'util';
import * as fs from 'fs';
import { Readable } from 'stream';
import { readFile } from 'fs/promises';

@Injectable()
export class ImageService {
  constructor() {}

  public async readImage(filePath: string): Promise<Buffer> {
    try {
      return await readFile(filePath);
    } catch (error) {
      // 파일을 읽어오는 중에 오류가 발생하면 처리
      throw new Error(`Error reading file: ${error.message}`);
    }
  }

  public async saveImage(path: string, imageBuffer: Buffer): Promise<string> {
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    if (!fs.existsSync(path)) {
      fs.mkdirSync(path, { recursive: true });
    }

    const pipeline = promisify(require('stream').pipeline);
    const folderPath = path;
    const fileName = generateRandomFileName();

    const readableImage = new Readable();
    readableImage.push(imageBuffer);
    readableImage.push(null);

    await pipeline(readableImage, fs.createWriteStream(`${folderPath}/${fileName}`));
    // 저장된 이미지의 경로 반환
    return `${folderPath}/${fileName}`;
  }
}
