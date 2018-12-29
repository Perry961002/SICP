```
(define (pairs s t)
    (interleave
        (stream-map (lambda (x) (list (stream-car s) x))
                    t)
        (pairs (stream-cdr s) (stream-cdr t))))
```
- 发现Louis的代码没有了延时求值，所以最终会导致溢出。