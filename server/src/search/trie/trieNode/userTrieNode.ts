import ITrieNode from '../interface/ITrieNode';

class UserTrieNode implements ITrieNode {
  children: { [key: string]: UserTrieNode } = {};
  isEndOfWord: boolean = false;
  userId: number[];
  constructor() {
    this.userId = [];
  }
}

export default UserTrieNode;
