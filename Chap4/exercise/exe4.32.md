```scheme
(define (solve f y0 dt)
  (define y (integral dy y0 dt))
  (define dy (stream-map f y)))
```

- 对微分方程的解过程，本小节的求值器可以同时延时计算`y`和`dy`。