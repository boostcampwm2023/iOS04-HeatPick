import { Test, TestingModule } from '@nestjs/testing';
import { SearchService } from './search.service';

describe('SearchService', () => {
  let service: SearchService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SearchService],
    }).compile();

    service = module.get<SearchService>(SearchService);
  });

  it('Graphme Separation Test', () => {
    expect(service.graphemeSeparation('안녕하세요')).toBe('ㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ');
  });
});
