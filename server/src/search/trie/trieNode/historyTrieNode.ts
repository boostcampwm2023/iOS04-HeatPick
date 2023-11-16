import ITrieNode from '../interface/ITrieNode';

class HistoryTrieNode implements ITrieNode {
  children: { [key: string]: HistoryTrieNode } = {};
  isEndOfWord: boolean = false;
}

export default HistoryTrieNode;
