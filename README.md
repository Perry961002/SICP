# 《计算机程序的构造和解释》---SICP学习记录
>> ![](https://img.shields.io/badge/language-Scheme-orange.svg) [![MIT license](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/LICENSE)

## A language isn’t something you learn so much as something you join.

<p align="center">
  <img src="http://groups.csail.mit.edu/mac/classes/6.001/abelson-sussman-lectures/wizard.jpg" alt="SICP"/>
</p>

## 为什么SICP那么重要！！！

- [这边文章](http://blog.fujiji.com/why-structure-and-interpretation-of-computer-programs-matters/)分析了SICP这门课为什么这么重要, 在开始SICP应该好好的读一下他。(英文原文:[Why Structure and Interpretation of Computer Programs matters](https://www.cs.berkeley.edu/~bh/sicp.html))

## 视频地址

- [中译版视频专辑列表（优酷）](https://v.youku.com/v_show/id_XNTEzMDAyMTU2.html?f=18958522)

## 配置环境

- 采用了Chez Scheme作为解释器, 从[这个链接](https://www.scheme.com/download/)下载安装并配置环境变量, 这里提供了[Scheme的中文入门教程](https://github.com/DeathKing/yast-cn), 对函数式编程有兴趣的话可以去读一下[这一篇文章](https://github.com/justinyhuang/Functional-Programming-For-The-Rest-of-Us-Cn/tree/master)

- 到这里就可以在DOS环境下进行程序编写, 但为了方便可以使用VS Code
    - [VS Code下载](https://code.visualstudio.com/), 安装之后为VS Code扩展`Code Runner`和`vscode-scheme`插件

    - 在VS Code的设置中搜索`code-runner.executorMapByFileExtension`, 在最后一行追加内容`".scm": "scheme"`, 安装好后重启一下VS Code这样就能在右上角看见一个三角形了，打开文件点击就能编译执行

    - 现在还不能在终端中输入命令观察效果, 解决方法是依次打开: `文件>首选项>设置>用户设置>拓展>Run Code Configuration`, 找到 `Run In Terminal` 打上勾, 这样运行的程序就会运行在集成控制台上

## 案例和习题代码

- 如果代码中有错误或者有疑惑, 欢迎通过[Issues](https://github.com/Perry961002/Learning-notes-of-SICP/issues)或者邮箱Perry961002@163.com联系

| 章节(Chapter) |  01  |  02  |  03  |  04  |  05  |
|:-------------:|:----:|:----:|:----:|:----:|:----:|
| 案例(Example) | [Code](https://github.com/Perry961002/Learning-notes-of-SICP/tree/master/Chap1/example) |  [Code](https://github.com/Perry961002/Learning-notes-of-SICP/tree/master/Chap2/example) | --- | --- | --- |
| 习题(Exercises) | [Code](https://github.com/Perry961002/Learning-notes-of-SICP/tree/master/Chap1/exercise)  | [Code](https://github.com/Perry961002/Learning-notes-of-SICP/tree/master/Chap2/exercise) | --- | --- | --- |
