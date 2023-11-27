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

  search(prefix: string[], limit: number): number[] {
    let node = this.root;
    for (const jaso of prefix) {
      if (!node.children[jaso]) {
        return [];
      }
      node = node.children[jaso];
    }

    return this.getWordsWithPrefix(node, prefix, limit);
  }

  getWordsWithPrefix(node: PlaceTrieNode, currentPrefix: string[], limit: number): number[] {
    let results: number[] = [];
    if (node.isEndOfWord) {
      results.push(...node.placeId);
      if (results.length === limit) return results;
    }

    for (const [jaso, childNode] of Object.entries(node.children)) {
      const childPrefix = [...currentPrefix, jaso];

      results = results.concat(this.getWordsWithPrefix(childNode, childPrefix, limit));
    }

    return results;
  }
}
