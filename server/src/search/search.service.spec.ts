import { Test, TestingModule } from '@nestjs/testing';
import { SearchService } from './search.service';
import { HistoryJasoTrie } from './trie/historyTrie';
import { StoryJasoTrie } from './trie/storyTrie';
import { SearchRepository } from './search.repository';
import { StoryRepository } from '../story/story.repository';

describe('SearchService', () => {
  let service: SearchService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SearchService, StoryJasoTrie, HistoryJasoTrie, { provide: SearchRepository, useFactory: () => ({}) }, { provide: StoryRepository, useFactory: () => ({}) }],
    }).compile();

    service = module.get<SearchService>(SearchService);
  });

  it('Graphme Separation Test', () => {
    expect(service.graphemeSeperation('안녕하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });
  it('Graphme Separation Test Including blank', () => {
    expect(service.graphemeSeperation('안녕 하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });
  it('Graphme Combination Test', () => {
    expect(service.graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕하세요');
  });
  it('Graphme Combination Test Including blank', () => {
    expect(service.graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕 하세요');
  });
  it('Search Automated Complete Test', () => {
    service.insertHistoryToTree(service.graphemeSeperation('안녕하세요'));
    service.insertHistoryToTree(service.graphemeSeperation('안녕하십니까'));
    service.insertHistoryToTree(service.graphemeSeperation('안녕'));

    const recommendedWords = service.searchHistoryTree(service.graphemeSeperation('안녕하'));
    expect(recommendedWords).toEqual(['안녕하세요', '안녕하십니까']);
  });
});
