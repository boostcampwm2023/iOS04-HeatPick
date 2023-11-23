import StoryTrieNode from './trieNode/storyTrieNode';

export class StoryJasoTrie {
  root: StoryTrieNode = new StoryTrieNode();

  insert(jasoArray: string[], storyId: number): void {
    let node = this.root;
    for (const jaso of jasoArray) {
      if (!node.children[jaso]) {
        node.children[jaso] = new StoryTrieNode();
      }
      node = node.children[jaso];
    }
    node.isEndOfWord = true;
    node.storyId.push(storyId);
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

  getWordsWithPrefix(node: StoryTrieNode, currentPrefix: string[], limit: number): string[][] {
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
