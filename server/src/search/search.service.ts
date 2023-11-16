import { Inject, Injectable } from '@nestjs/common';
import * as Hangul from 'hangul-js';
import { JasoTrie } from './trie/trie';

@Injectable()
export class SearchService {
  constructor(private jasoTrie: JasoTrie) {}

  insertTree(separatedStatement: string[]) {
    this.jasoTrie.insert(separatedStatement);
  }

  searchTree(separatedStatement: string[]) {
    const recommendedWords = this.jasoTrie.search(separatedStatement);
    return recommendedWords.map((word) => this.graphemeCombination(word));
  }

  graphemeSeparation(text: string): string[] {
    return Hangul.disassemble(text);
  }

  graphemeCombination(separatedStatement: string[]): string {
    return Hangul.assemble(separatedStatement);
  }
}
