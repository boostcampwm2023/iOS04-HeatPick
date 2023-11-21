import { ConflictException } from '@nestjs/common';

export class InvalidIdException extends ConflictException {
  constructor() {
    super('Valid 하지 않은 ID입니다.');
  }
}
