import { ConflictException } from '@nestjs/common';

export class idDuplicatedException extends ConflictException {
  constructor() {
    super('idDuplicated');
  }
}
