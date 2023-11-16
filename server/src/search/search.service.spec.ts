import { Test, TestingModule } from '@nestjs/testing';
import { SearchService } from './search.service';
import { JasoTrie } from './trie/trie';

describe('SearchService', () => {
  let service: SearchService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SearchService, JasoTrie],
    }).compile();

    service = module.get<SearchService>(SearchService);
  });

  it('Graphme Separation Test', () => {
    expect(service.graphemeSeparation('안녕하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });
  it('Graphme Separation Test Including blank', () => {
    expect(service.graphemeSeparation('안녕 하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });
  it('Graphme Combination Test', () => {
    expect(service.graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕하세요');
  });
  it('Graphme Combination Test Including blank', () => {
    expect(service.graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕 하세요');
  });
  it('Search Automated Complete Test', () => {
    service.insertHistoryToTree(service.graphemeSeparation('안녕하세요'));
    service.insertHistoryToTree(service.graphemeSeparation('안녕하십니까'));
    service.insertHistoryToTree(service.graphemeSeparation('안녕'));

    const recommendedWords = service.searchHistoryTree(service.graphemeSeparation('안녕하'));
    expect(recommendedWords).toEqual(['안녕하세요', '안녕하십니까']);
  });
});
