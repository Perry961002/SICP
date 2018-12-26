- 本题代码主要做了下面的改动：
```
(let ((protected (make-serializer)))
  (let ((protected-withdraw (protected withdraw))
        (protected-deposit (protected deposit)))
    (define (dispatch m)
      (cond
        ((eq? m 'withdraw) protected-withdraw)
        ((eq? m 'deposit) protected-deposit)
        ((eq? m 'balance) balance)
        (else (error "Unknown request -- MAKE-ACCOUNT" m))))
    dispatch))
```
- 可以发现这里作者让每个`withdraw`和`deposit` `共享`一个对应的串行化过程，不能确定内部是否会产生`交错`的情况