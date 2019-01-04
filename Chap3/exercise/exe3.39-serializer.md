```scheme
(define x 10)
(define s (make-serializer))

(parallel-execute 
  (lambda (x) (set! x ((s (lambda () (* x x)))))
  (s (lambda () (set! x (+ x 1)))))
```
- 首先分析一下上面的代码，`p2`完全被串行化，但是p1中只是求x^2的过程被串行化，这里用`p12`表示`set!`操作，`p11`表示被串行化的`x^`2过程。那么很自然可以得到下面的情况：
1. `p11 --> p12 --> p2`，结果为`101`
2. `p2 --> p11 --> p12`，结果为`121`
3. `p11 --> p2 --> p12`，结果为`100`

