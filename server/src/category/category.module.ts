import { Module } from '@nestjs/common';
import { DatabaseModule } from '../db/database.module';
import { CategoryProvider } from './category.provider';
import { CategoryService } from './category.service';
import { CategoryController } from './category.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [CategoryController],
  providers: [...CategoryProvider, CategoryService],
  exports: [CategoryService],
})
export class CategoryModule {}
