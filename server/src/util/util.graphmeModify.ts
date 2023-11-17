import * as Hangul from 'hangul-js';

export function graphemeSeperation(text: string): string[] {
  return Hangul.disassemble(text);
}

export function graphemeCombination(separatedStatement: string[]): string {
  return Hangul.assemble(separatedStatement);
}
