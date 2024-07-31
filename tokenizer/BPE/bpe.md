

# 有关Subword的tokenizer算法

## BPE
接下来正式介绍 BPE 分词算法的训练流程，假设我们手头有一堆文档 $D={d_1,d_2,…}$

1. 把每个文档 $d$ 变成单词列表，比如你可以简单用空格分词
2. 统计每个单词 $w$ 在所有文档 $D$ 中的出现频率，并计算初始字符集 alphabet 作为一开始的 Vocab（包括后面的 </w>），字符集的意思就是所有文档 $D$ 中不同的字符集合
3. 先将每个单词划分为一个个 utf-8 char，称为一个划分，比如 highest -> h, i, g, h, e, s, t
4. 然后，在每个单词的划分最后面加上 </w>，那么现在 highest -> h, i, g, h, e, s, t, </w>
5. 重复下面步骤直到满足两个条件中的任意一个：1）Vocab 达到上限。2）达到最大迭代次数

找到最经常一起出现的 pair，并记录这个合并规则，放在 merge table 里面，同时把合并之后的结果放到 Vocab 里面
更新所有单词的划分，假设我们发现 (h, i) 最经常一起出现，那么 hi 就会被添加到 Vocab 里面，同时修改划分方式为：highest -> hi, g, h, e, s, t, </w>



你可能会有下面 3 个疑惑：

- 为什么要统计词频？因为统计词频会让找最经常出现的 pair 这件事变得简单
- 为什么要加 </w>？因为我们希望能够还原输入，因此需要做个标记表示这是单词之间的边界
- 如果多个 pair 的词频一样怎么处理？这个不同实现可能不一样，但在我看来应该关系不大

### BPE的例子

停留在算法不提供例子的话，经常还是会云里雾里，所以现在来结合一个例子看 BPE 是如何工作的

比如语料库是

```
corpus = ["highest", "higher", "lower", "lowest", "cooler", "coolest"]
```
这里跳过统计词频，因为每一个都是 1。先把每个单词变成一个个 utf-8 字符然后加上 </w>

```
{
    "highest": ["h", "i", "g", "h", "e", "s", "t", "</w>"],
    "higher": ["h", "i", "g", "h", "e", "r", "</w>"],
    "lower": ["l", "o", "w", "e", "r", "</w>"],
    "lowest": ["l", "o", "w", "e", "s", "t", "</w>"],
    "cooler": ["c", "o", "o", "l", "e", "r", "</w>"],
    "collest": ["c", "o", "o", "l", "e", "s", "t", "</w>"],
}
```
可以看到 (e, s) 总共出现了 3 次，是最多次的，将 es 添加到 Vocab 里面，然后重新划分。注意这里 (e, r) 其实也有一样的出现频率，所以选 (e, r) 合并也是可以的

```
{
    "highest": ["h", "i", "g", "h", "es", "t", "</w>"],
    "higher": ["h", "i", "g", "h", "e", "r", "</w>"],
    "lower": ["l", "o", "w", "e", "r", "</w>"],
    "lowest": ["l", "o", "w", "es", "t", "</w>"],
    "cooler": ["c", "o", "o", "l", "e", "r", "</w>"],
    "collest": ["c", "o", "o", "l", "es", "t", "</w>"],
}
```
接下来发现最多的是 (es, t)，更新划分
```

{
    "highest": ["h", "i", "g", "h", "est", "</w>"],
    "higher": ["h", "i", "g", "h", "e", "r", "</w>"],
    "lower": ["l", "o", "w", "e", "r", "</w>"],
    "lowest": ["l", "o", "w", "est", "</w>"],
    "cooler": ["c", "o", "o", "l", "e", "r", "</w>"],
    "collest": ["c", "o", "o", "l", "est", "</w>"],
}
```
接下来发现最多的是 (est, </w>)，更新划分
```

{
    "highest": ["h", "i", "g", "h", "est</w>"],
    "higher": ["h", "i", "g", "h", "e", "r", "</w>"],
    "lower": ["l", "o", "w", "e", "r", "</w>"],
    "lowest": ["l", "o", "w", "est</w>"],
    "cooler": ["c", "o", "o", "l", "e", "r", "</w>"],
    "collest": ["c", "o", "o", "l", "est</w>"],
}
```
接下来发现最多的是 (e, r)，更新划分

```
{
    "highest": ["h", "i", "g", "h", "est</w>"],
    "higher": ["h", "i", "g", "h", "er", "</w>"],
    "lower": ["l", "o", "w", "er", "</w>"],
    "lowest": ["l", "o", "w", "est</w>"],
    "cooler": ["c", "o", "o", "l", "er", "</w>"],
    "collest": ["c", "o", "o", "l", "est</w>"],
}
```
接下来发现最多的是 (er, </w>)，更新划分
```
{
    "highest": ["h", "i", "g", "h", "est</w>"],
    "higher": ["h", "i", "g", "h", "er</w>"],
    "lower": ["l", "o", "w", "er</w>"],
    "lowest": ["l", "o", "w", "est</w>"],
    "cooler": ["c", "o", "o", "l", "er</w>"],
    "collest": ["c", "o", "o", "l", "est</w>"],
} 
```

具体的算法代码去看 [BPE算法代码---手搓版](./byhand/bpe.ipynb)


具体的算法代码去看 [BPE算法代码---超级无敌简单版](./byHuggingface//bpe.ipynb)
<br>
<hr>

## Unigram
## SentencePiece
## WordPiece
### 这几个都可以简单看一下原理，代码与BPE差不太多。
<br>
<hr>
## SententcePiece




## :relexed: 尽管huggingface构建tokenizer很方便，但我还是建议您尝试一下手撸bpe代码