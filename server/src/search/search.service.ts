import { Injectable } from '@nestjs/common';
import * as Hangul from 'hangul-js';

@Injectable()
export class SearchService {
  async recommendSearch(): Promise<any> {
    return 1;
  }

  graphemeSeparation(text: string): string {
    return Hangul.disassemble(text).join('');
  }

  graphemeCombination(separatedStatement: string): string {
    return Hangul.assemble(separatedStatement.split(''));
  }
}
