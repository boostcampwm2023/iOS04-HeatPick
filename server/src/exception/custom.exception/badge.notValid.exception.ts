import { ConflictException } from '@nestjs/common';

export class InvalidBadgeException extends ConflictException {
  constructor() {
    super('Valid 하지 않은 Badge Name입니다.');
  }
}
