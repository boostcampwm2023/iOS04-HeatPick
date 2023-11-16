import { HttpException } from '@nestjs/common';

export class invalidTokenException extends HttpException {
  constructor() {
    super('Invalid Token', 498);
  }
}
