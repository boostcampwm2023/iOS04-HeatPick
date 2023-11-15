import { Injectable } from '@nestjs/common';
import * as Hangul from 'hangul-js';

@Injectable()
export class SearchService {
  async recommendSearch(): Promise<any> {
    return 1;
  }

  graphemeSeparation(text: string): string {
    const separatedStatement: string[] = [];
    for (let i = 0; i < text.length; i++) {
      const char = text[i];
      if (Hangul.isHangul(char)) {
        const jamoArray = Hangul.disassemble(char);
        separatedStatement.push(...jamoArray);
      } else {
        separatedStatement.push(char);
      }
    }
    const result = separatedStatement.join('');
    return result;
  }
}
