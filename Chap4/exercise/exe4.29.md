- 选用递归方式的斐波那契数求法

  ```scheme
  (define (fib n)
    (if (< n 1)
      n
      (+ (fib (- n 1))
         (fib (- n 2)))))
  ```

  