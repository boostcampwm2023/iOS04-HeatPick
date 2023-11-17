import ITrieNode from '../interface/ITrieNode';

class StoryTrieNode implements ITrieNode {
  children: { [key: string]: StoryTrieNode } = {};
  isEndOfWord: boolean = false;
  storyId: number[];
  constructor() {
    this.storyId = [];
  }
}

export default StoryTrieNode;
