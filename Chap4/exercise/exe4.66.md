```scheme
(rule ?amount
      (and (job ?x (computer programmer))
           (salary ?x ?amount)))
```

- 这里的问题与`4.65`类似，即会产生重复的结果，会造成一些值被重复计算。
- 所以映射函数应该添加一个过滤重复结果的操作。