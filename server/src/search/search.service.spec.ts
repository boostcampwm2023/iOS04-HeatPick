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
  it('Graphme Separation Test Including blank', () => {
    expect(service.graphemeSeparation('안녕 하세요')).toBe('ㅇㅏㄴㄴㅕㅇ ㅎㅏㅅㅔㅇㅛ');
  });
  it('Graphme Combination Test', () => {
    expect(service.graphemeCombination('ㅇㅏㄴㄴㅕㅇㅎㅏㅅㅔㅇㅛ')).toBe('안녕하세요');
  });
  it('Graphme Combination Test Including blank', () => {
    expect(service.graphemeCombination('ㅇㅏㄴㄴㅕㅇ ㅎㅏㅅㅔㅇㅛ')).toBe('안녕 하세요');
  });
});
