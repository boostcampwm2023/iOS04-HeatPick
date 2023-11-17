interface ITrieNode {
  children: { [key: string]: ITrieNode };
  isEndOfWord: boolean;
}

export default ITrieNode;
