# a)
```
因为如果这些进程是顺序运行的话，就不会出现一个进程访问 balance 时，另一个进程修改 balance 的情况，更不会出现同时写的情况。
```
# b)
- 这里得出的结果是`a1 = 20, a2 = 20, a3 = 20`。
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.43/a.jpg" alt="a"/>
</p>
# c)
```
因为在 exchange 内部 withdraw 和 deposit 是顺序执行的，最终一定会保持 exchange 的两个参数的和是相等的，则多个账户或多次过程的情况下总和肯定也是一样的。
```
# d)
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.43/b.jpg" alt="b"/>
</p>
