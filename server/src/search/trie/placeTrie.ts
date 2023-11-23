import PlaceTrieNode from './trieNode/placeTrieNode';

export class PlaceJasoTrie {
  root: PlaceTrieNode = new PlaceTrieNode();

  insert(jasoArray: string[], placeId: number): void {
    let node = this.root;
    for (const jaso of jasoArray) {
      if (!node.children[jaso]) {
        node.children[jaso] = new PlaceTrieNode();
      }
      node = node.children[jaso];
    }
    node.isEndOfWord = true;
    node.placeId.push(placeId);
  }

  search(prefix: string[], limit: number): string[][] {
    let node = this.root;
    for (const jaso of prefix) {
      if (!node.children[jaso]) {
        return [];
      }
      node = node.children[jaso];
    }

    return this.getWordsWithPrefix(node, prefix, limit);
  }

  getWordsWithPrefix(node: PlaceTrieNode, currentPrefix: string[], limit: number): string[][] {
    let results: string[][] = [];
    if (node.isEndOfWord) {
      results.push(currentPrefix);
      if (results.length == limit) return results;
    }

    for (const [jaso, childNode] of Object.entries(node.children)) {
      const childPrefix = [...currentPrefix, jaso];
      results = results.concat(this.getWordsWithPrefix(childNode, childPrefix, limit - results.length));
      if (results.length == limit) return results;
    }

    return results;
  }
}
