```scheme
(define (sqrt-stream x)
    (stream-cons 1.0
                 (stream-map (lambda (guess)
                                (sqrt-improve guess x))
                             (sqrt-stream x))))
```
- 发现在`stream-map`还调用了`(sqrt-stream x)`，造成了大量的重复计算，两个版本不会有效率差异，都有重复的运算x之前数的过程。

