- 给出这两个定义：

  ```scheme
  (define (unless condition usual-value exceptional-value)
    (if condition exceptional-value usual-value))
  
  (define (factorial n)
    (unless (= n 1)
            (* n (factorial (- n 1)))
            1))
  ```

  - 对于`应用序`来说是会出错的，因为在`factorial`中调用了自身，所以必须把`(factorial (- n 1))`求出之后才能传给`unless`，造成了`死循环`。
  - 对于`正则序`来说则不会，它允许在参数还`没有完成求值前就进入一个过程的体`。

