import { Test, TestingModule } from '@nestjs/testing';
import { SearchService } from './search.service';
import { HistoryJasoTrie } from './trie/historyTrie';
import { StoryJasoTrie } from './trie/storyTrie';
import { SearchRepository } from './search.repository';
import { UserJasoTrie } from './trie/userTrie';
import { graphemeCombination, graphemeSeperation } from '../util/util.graphmeModify';

describe('Graphme Seperation & Combination Test', () => {
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [],
    }).compile();
  });

  it('Graphme Seperation Test', () => {
    expect(graphemeSeperation('안녕하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });

  it('Graphme Seperation Test Including blank', () => {
    expect(graphemeSeperation('안녕 하세요')).toStrictEqual(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ']);
  });

  it('Graphme Combination Test', () => {
    expect(graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕하세요');
  });

  it('Graphme Combination Test Including blank', () => {
    expect(graphemeCombination(['ㅇ', 'ㅏ', 'ㄴ', 'ㄴ', 'ㅕ', 'ㅇ', ' ', 'ㅎ', 'ㅏ', 'ㅅ', 'ㅔ', 'ㅇ', 'ㅛ'])).toBe('안녕 하세요');
  });
});

describe('Search Automation Test', () => {
  let service: SearchService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [SearchService, StoryJasoTrie, HistoryJasoTrie, UserJasoTrie, { provide: SearchRepository, useFactory: () => ({ loadEveryHistory: jest.fn() }) }],
    }).compile();

    service = module.get<SearchService>(SearchService);
  });

  it('Search Automated Complete Test', () => {
    service.insertHistoryToTree(graphemeSeperation('안녕하세요'));
    service.insertHistoryToTree(graphemeSeperation('안녕하십니까'));
    service.insertHistoryToTree(graphemeSeperation('안녕'));

    const recommendedWords = service.searchHistoryTree(graphemeSeperation('안녕하'));
    expect(recommendedWords).toEqual(['안녕하세요', '안녕하십니까']);
  });
});
