import { Inject, Injectable } from '@nestjs/common';
import { Category } from '../entities/category.entity';
import { Repository } from 'typeorm';

@Injectable()
export class CategoryService {
  constructor(@Inject('CATEGORY_REPOSITORY') private categoryRepository: Repository<Category>) {}

  public async getCategoryList(): Promise<Category[]> {
    return await this.categoryRepository.find();
  }

  public async getCategory(categoryId: number): Promise<Category> {
    return await this.categoryRepository.findOneBy({ categoryId: categoryId });
  }
}
