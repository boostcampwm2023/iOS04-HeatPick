class TrieNode {
  children: { [key: string]: TrieNode } = {};
  isEndOfWord: boolean = false;
}

export class JasoTrie {
  root: TrieNode = new TrieNode();

  insert(jasoArray: string[]): void {
    let node = this.root;
    for (const jaso of jasoArray) {
      if (!node.children[jaso]) {
        node.children[jaso] = new TrieNode();
      }
      node = node.children[jaso];
    }
    node.isEndOfWord = true;
  }

  search(prefix: string[]): string[][] {
    let node = this.root;
    for (const jaso of prefix) {
      if (!node.children[jaso]) {
        return [];
      }
      node = node.children[jaso];
    }

    return this.getWordsWithPrefix(node, prefix);
  }

  getWordsWithPrefix(node: TrieNode, currentPrefix: string[]): string[][] {
    let results: string[][] = [];
    if (node.isEndOfWord) {
      results.push(currentPrefix);
    }

    for (const [jaso, childNode] of Object.entries(node.children)) {
      const childPrefix = [...currentPrefix, jaso];
      results = results.concat(this.getWordsWithPrefix(childNode, childPrefix));
    }

    return results;
  }
}
