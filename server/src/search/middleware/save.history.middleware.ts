import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { SearchService } from '../search.service';

@Injectable()
export class SaveHistoryMiddleware implements NestMiddleware {
  constructor(private readonly searchService: SearchService) {}

  use(req: Request, res: Response, next: NextFunction) {
    const searchText = req.query.searchText as string;
    this.searchService.saveHistory(searchText);
    next();
  }
}
