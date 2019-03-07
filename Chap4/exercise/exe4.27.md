- 定义：

  ```scheme
  (define count 0)
  
  (define (id x)
    (set! count (+ count 1))
    x)
  
  (define w (id (id 10)))
  ```

  第一个输出：`1`

  ```
  外层的 id 会被调用
  ```

  第二个输出：`10`

  第三个：`2`

  ```
  对 w 求值，会导致内层的 id 会被调用，所以count 为 2
  ```

  

