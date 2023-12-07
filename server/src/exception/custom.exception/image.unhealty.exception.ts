import { ConflictException } from '@nestjs/common';

export class ImageUnhealthyException extends ConflictException {
  constructor() {
    super('허용되지 않는 이미지가 검색되었습니다.');
  }
}
