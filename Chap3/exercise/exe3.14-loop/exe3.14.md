- 给出书中的代码
```
(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                (set-cdr! x y)
                (loop temp x))))
    (loop x '()))
```

- `简单分析一下loop过程的代码可以知道，它将x翻转之后把cdr指针指向了y。`
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.14-loop/a.jpg" alt="a"/>
</p>

`因此mystery就是将x翻转。`