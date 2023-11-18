import ITrieNode from '../interface/ITrieNode';

class PlaceTrieNode implements ITrieNode {
  children: { [key: string]: PlaceTrieNode } = {};
  isEndOfWord: boolean = false;
  placeId: number[];
  constructor() {
    this.placeId = [];
  }
}

export default PlaceTrieNode;
