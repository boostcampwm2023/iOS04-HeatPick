import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './db/database.module';
import { AuthModule } from './auth/auth.module';
import { StoryModule } from './story/story.module';
import { Injectable, NestMiddleware, Logger } from '@nestjs/common';

import { Request, Response, NextFunction } from 'express';
import { SearchController } from './search/search.controller';
import { SearchService } from './search/search.service';
import { SearchModule } from './search/search.module';
import { ImageModule } from './image/image.module';
import { CommentModule } from './comment/comment.module';
import { SlackService } from './slack/slack.service';
import { APP_FILTER } from '@nestjs/core';
import { SlackExceptionFilter } from './exception/slack-exception.filter';
import axios from 'axios';

@Injectable()
export class AppLoggerMiddleware implements NestMiddleware {
  private logger = new Logger('HTTP');

  async use(request: Request, response: Response, next: NextFunction) {
    try {
      const { ip, method, originalUrl } = request;
      const clientIP = request.headers['x-forwarded-for'] || request.socket.remoteAddress;
      const userAgent = request.get('user-agent') || '';

      response.on('finish', () => {
        const { statusCode } = response;
        const contentLength = response.get('content-length');
        this.logger.log(`${method} ${originalUrl} ${statusCode} ${contentLength} - ${userAgent} ${ip} ${clientIP}`);
      });

      const countryResponse = await axios.get(`https://ipinfo.io/${clientIP}/json`);
      const country = countryResponse.data.country;

      const allowedCountries = ['KR'];
      //if (!allowedCountries.includes(country)) {
      //  return response.status(403).send('Access denied By IP control policy');
      // }

      next();
    } catch (error) {
      console.error('error while processing country IP');
      next();
    }
  }
}
@Module({
  imports: [DatabaseModule, AuthModule, StoryModule, SearchModule, ImageModule, CommentModule],
  controllers: [AppController],
  providers: [
    AppService,
    SlackService,
    {
      provide: APP_FILTER,
      useClass: SlackExceptionFilter,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): void {
    consumer.apply(AppLoggerMiddleware).forRoutes('*');
  }
}
