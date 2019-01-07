```
;过程append!
(define (append! x y)
    (set-cdr! (last-pair x) y)
    x)

;过程last-pair，返回参数的最后一个序对
(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))
```

`(define x (list 'a 'b))`

`(define y (list 'c 'd))`

`(define z (append x y))`

`(cdr x) ; (b)`

`(define w (append! x y))`

`(cdr x) ; (b c d)`

![](a.jpg)