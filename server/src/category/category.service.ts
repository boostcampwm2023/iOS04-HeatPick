import { Inject, Injectable } from '@nestjs/common';
import { Category } from '../entities/category.entity';
import { Repository } from 'typeorm';
import { Transactional } from 'typeorm-transactional';

@Injectable()
export class CategoryService {
  constructor(@Inject('CATEGORY_REPOSITORY') private categoryRepository: Repository<Category>) {}

  @Transactional()
  public async getCategoryList(): Promise<Category[]> {
    return await this.categoryRepository.find();
  }

  @Transactional()
  public async getCategory(categoryId: number): Promise<Category> {
    return await this.categoryRepository.findOneBy({ categoryId: categoryId });
  }
}
