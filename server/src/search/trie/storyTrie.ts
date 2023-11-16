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

  search(prefix: string[]): number[] {
    let node = this.root;
    for (const jaso of prefix) {
      if (!node.children[jaso]) {
        return [];
      }
      node = node.children[jaso];
    }

    return this.getWordsWithPrefix(node, prefix);
  }

  getWordsWithPrefix(node: StoryTrieNode, currentPrefix: string[]): number[] {
    let results: number[] = [];
    if (node.isEndOfWord) {
      results.concat(node.storyId);
    }

    for (const [jaso, childNode] of Object.entries(node.children)) {
      const childPrefix = [...currentPrefix, jaso];
      results = results.concat(this.getWordsWithPrefix(childNode, childPrefix));
    }

    return results;
  }
}
