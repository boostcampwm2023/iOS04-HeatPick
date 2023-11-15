import { ExceptionFilter, Catch, ArgumentsHost, HttpException } from '@nestjs/common';
import { Request, Response } from 'express';

@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  isExceptionWithStatus(obj: any): obj is { getStatus: () => number } {
    return typeof obj === 'object' && 'getStatus' in obj && typeof obj.getStatus === 'function';
  }
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    const status = this.isExceptionWithStatus(exception) ? exception.getStatus() : 500;

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
    });
  }
}
