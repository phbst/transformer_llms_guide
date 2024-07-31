bert用的是wordpiece, wordpiece算法可以看作是BPE的变种。

不同的是，WordPiece基于概率生成新的subword而不是下一最高频字节对。

WordPiece算法也是每次从词表中选出两个子词合并成新的子词。BPE选择频数最高的相邻子词合并，而WordPiece选择使得语言模型概率最大的相邻子词加入词表。


WordPiece的工作原理如下：

- 从词汇表中的所有单词开始。
- 使用给定的词汇大小作为限制，迭代地选择最佳的单词或字符序列进行合并。
- 在每次迭代中，选择能最大化模型的语言概率的合并。
- 这个过程会持续，直到词汇表达到预设的大小。