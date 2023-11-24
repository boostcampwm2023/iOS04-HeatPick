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

  getWordsWithPrefix(node: StoryTrieNode, currentPrefix: string[], limit: number): number[] {
    let results: number[] = [];
    if (node.isEndOfWord) {
      results.push(...node.storyId);
      if (results.length === limit) return results;
    }

    for (const [jaso, childNode] of Object.entries(node.children)) {
      const childPrefix = [...currentPrefix, jaso];
      results = results.concat(this.getWordsWithPrefix(childNode, childPrefix, limit - results.length));
      if (results.length === limit) return results;
    }

    return results;
  }
}
