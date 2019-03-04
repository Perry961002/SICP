- 题目中给出的扫描出定义的方式;

  ```scheme
  (lambda <vars>
    (let ((u '*unassigned*)
          (v '*unassigned*))
      (let ((a <e1>)
            (b <e2>))
        (set! u a)
        (set! v b))
      <e3>))
  ```

  关于这种方式与正文中提供方式的不同，作者已经给出了说明：

  > 它将强加一种限制，要求被定义变量的值能在不用其他变量的值的情况下进行求值。- 

- 下面是solve过程的定义，这里面使用了延迟计算技术

  ```scheme
  (define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)
  ```

- 按题目给出的方式变换一下得到：

  ```scheme
  (define (solve f y0 dt)
    (let ((y '*unassigned*)
          (dy '*unassigned*))
      (let ((a (integral (delay dy) y0 dt))
            (b (stream-map f y)))
        (set! y a)
        (set! dy b))
      y))
  ```

  因为`(delay dy)`使用了延迟计算技术，虽然`dy`并没有算出，但也是对的。

  而下面一行的`(stream-map f y)`，因为此时的`y`的值还是`'*unassigned*'`，所以会报错而无法工作。

- 按照正文中变换方式进行变换得到：

  ```scheme
  (define (solve f y0 dt)
    (let ((y '*unassigned*)
          (dy '*unassigned*))
      (set! y (integral (delay dy yo dt)))
      (set! dy (stream-map f y))
      y))
  ```

  这里我们可以清楚的看到求`(stream-map f y)`时`y`已被算出，所以这种方式时可以的。