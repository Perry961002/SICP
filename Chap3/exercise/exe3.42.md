- 本题代码主要做了下面的改动：
```scheme
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
- 因为`make-serializer`的功能就是使其作用的过程顺序化，原文给出的方式肯定是顺序化的了，至于本题修改后的方式，其实也是顺序化的，因为一旦把某过程作为参数传给`make-serializer`后，就相当于给该过程加了一个`互斥锁`，而且该互斥锁是针对方法的，所以修改后的方式也是顺序执行的。

