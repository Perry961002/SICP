```scheme
(define (squarer a b)
    (multiplier a a b))
```
- 对`multiplier`来说`m1`和`m2`共享一根连接器`a`，当`a`的值被忘记之后`multiplier`不能处理`m1`和`m2`都没有值的情况

