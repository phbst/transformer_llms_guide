# tokenizer的定义

>tokenizer也叫分词器

作用：

- **文本序列**通过 Tokenizer 被转化为**数字序列**（token 编号/id）。
- 是训练和微调大型语言模型（LLM）必不可少的一部分。  
  
---

![tokenizer的作用](/static/tokenizer/image/tokenizer分词.png)

---
Tokenizer 在transformer的架构中处于**Embdedding Input**区域，如图（内置）

![transformer架构](/static/transformer/image/transformer架构.png)




# 不同粒度的分词

## Word-based Tokenizers

![Word-based-Tokenizer](/static/tokenizer/image/tokenizer_id.png)

优点：符合人的自然语言直觉

缺点：很多相同意义的词分到一起，词表很大

<br>

## character-based Tokenizers

这个此表就很小了，但是很显然，他的单词信息量很小，同时对中文来说也不友好。
<br>

![ 优缺 ](/static/tokenizer/image/分词粒度优缺.png)

## Subword-based Tokenizers
基于词的字词来切分


![整合](/static/tokenizer/image/tokenizer整合.png)


总结来说，基于Subword该粒度的切分效果是最好的。所以接下来的分词算法都是Subword的变体。
<br>

*
-
-
-
# 有关Subword的tokenizer算法

## BPE


## WorldPiece 

## SententcePiece



