import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CategoryProvider } from './category.provider';
import { CategoryService } from './category.service';

@Module({
  imports: [DatabaseModule],
  controllers: [],
  providers: [...CategoryProvider, CategoryService],
  exports: [CategoryService],
})
export class CategoryModule {}
