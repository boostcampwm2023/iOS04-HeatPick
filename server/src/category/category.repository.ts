import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Category } from '../entities/category.entity';

@Injectable()
export class CategoryRepository {
  constructor(
    @Inject('CATEGORY_REPOSITORY')
    private categoryRepository: Repository<Category>,
  ) {}

  async finAll() {
    return await this.categoryRepository.find();
  }

  async findById(categoryId: number) {
    return await this.categoryRepository.findOneBy({ categoryId: categoryId });
  }
}
