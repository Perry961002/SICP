```
(define s (stream-cons 1 (add-stream s s)))
```
- s的car为1，cdr为求值s每个元素*2的许诺，所以s是2的各个幂。