# 《计算机程序的构造和解释》---SICP学习记录
![](https://img.shields.io/badge/language-Scheme-orange.svg) [![MIT license](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/LICENSE)

## A language isn’t something you learn so much as something you join. ( 语言不是你学习的东西，而是你加入的东西。)

<p align="center">
  <img src="http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/wizard.jpg" alt="SICP"/>
</p>

## 为什么SICP那么重要！！！

- [这边文章](http://blog.fujiji.com/why-structure-and-interpretation-of-computer-programs-matters/)分析了SICP这门课为什么这么重要，在开始学习SICP之前应该好好的读一下它。(英文原文:[Why Structure and Interpretation of Computer Programs matters](https://www.cs.berkeley.edu/~bh/sicp.html))
- 如果对于理论基础**λ-演算**有兴趣的话可以读一下存储库里给出的文档：[lambda演算](lambda演算.pdf)。
- 现在绝大多数的计算理论都是讨论的图灵机的理论，但是可能使用lambda演算理论会有不一样的效果，王垠大神也对此有所讨论，并推荐了一本有关的书籍[《程序设计视角下的可计算和复杂性理论》](程序视角下的可计算和复杂性理论.pdf)（已收录在存储库中）。

## 读完SICP的感受!!!

- 这里引用在简书上看的一句话:

  **SICP有什么缺点吗？有！它会让你在精神得到满足之余，有一种孤独感。**

## 视频地址

- [中译版视频专辑列表（优酷）](https://v.youku.com/v_show/id_XNTEzMDAyMTU2.html?f=18958522)，视频只能是入门，想要真的掌握SICP这门课应该去读纸质书并且认真完成书后的习题。

## 一点建议

- 首先本书是一本非常经典的教材，也是非常有难度的书，很多内容、习题需要仔细揣摩才能领略其奥妙之处，所以想读完甚至是掌握精髓是很需要下功夫的。
- 其次，在阅读时，请务必全神贯注，并使用一整段的时间来学习每一小节并认真思考习题，否则很难有所收获。
- 最后想说持续的学习总是很苦，所以当你学习SICP时觉得累、烦躁了，不妨停下来听听音乐，或者出去走走，总之一切放松的方式都行，但请记得这里还有许多富有趣味的题目亟待解决，它们等待你重新燃起热情去战胜。
- 如果在学习过程中遇到觉得句子难以理解的地方可以去查看一下译者给出的[勘误表](http://www.math.pku.edu.cn/teachers/qiuzy/books/sicp/errata.htm), 不要问我为什么特意提这个, 你懂的...

以上与所有的SICP的学习者共勉！！:tada:

## 我的时间线

- Nov 20, 2018 ~ Nov 24, 2018 --- 第1章 《构造过程抽象》
- Nov 25, 2018 ~ Dec 11, 2018 --- 第2章 《构造数据抽象》
- Dec 12, 2018 ~ Dec 30, 2018 --- 第3章 《模块化、对象和状态》
- Mar 03, 2019 ~ Mar 11, 2019 --- 第4章 《元语言抽象》

...准备春招！！

## 配置环境

- 采用了Chez Scheme作为解释器，需要从[这个链接](https://www.scheme.com/download/)下载安装并配置环境变量，这里提供了[Scheme的中文入门教程](https://github.com/DeathKing/yast-cn)，对函数式编程有兴趣的话可以去读一下[这一篇文章](https://github.com/justinyhuang/Functional-Programming-For-The-Rest-of-Us-Cn/tree/master)。

- 到这里就可以在DOS环境下进行程序编写，但为了方便可以使用VS Code
    - [VS Code下载地址](https://code.visualstudio.com/)， 安装之后为VS Code扩展`Code Runner`和`vscode-scheme`插件。

    - 在VS Code的设置中搜索`code-runner.executorMapByFileExtension`，在最后一行追加内容`".scm": "scheme"`，安装好后重启一下VS Code这样就能在右上角看见一个三角形了，打开文件点击就能编译执行。

    - 现在还不能在终端中输入命令观察效果，解决方法是依次打开: `文件>首选项>设置>用户设置>拓展>Run Code Configuration`，找到 `Run In Terminal` 打上勾，这样运行的程序就会运行在集成控制台上。
- 特别说明：在学习第三章关于流的内容时，将使用Racket作为解释器([下载地址](https://download.racket-lang.org/))，因为它内部已经实现了这一技术。

## 案例和习题代码

- 感谢我的同学[Mo-lemon](https://github.com/Mo-lemon)帮助我将之前习题中手绘的环境模型图用Visio重新绘制。

- 如果代码中有错误或者有疑惑，欢迎通过[Issues](https://github.com/Perry961002/Learning-notes-of-SICP/issues)指出或者邮箱Perry961002@163.com联系我。

| 章节(Chapter) |  01  |  02  |  03  |  04  |  05  |
|:-------------:|:----:|:----:|:----:|:----:|:----:|
| 案例(Example) | [Code](Chap1/example) |  [Code](Chap2/example) | [Code](Chap3/example) | [Code](Chap4/example) | --- |
| 习题(Exercises) | [Code](/Chap1/exercise)  | [Code](Chap2/exercise) | [Code](Chap3/exercise) | [Code](Chap4/exercise) | --- |

## Scheme实现几个经典算法

- [快速排序(QuickSort)](little%20practice/quicksort.md)

- [归并排序(MergeSort)](little%20practice/merge-sort.md)

- [堆排序(HeapSort)](little%20practice/HeapSort.md)