- Louis的想法多此一举
```
对比 exchange 和 transfer 的代码可以发现 exchange 对各个账户需要多次使用，而 transfer 只需要一次，因此只要保证 transfer 中的 withdraw 和 deposit 顺序执行即可。
```