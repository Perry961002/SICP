- 先看一下inverter过程的代码
```scheme
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! input invert-input)
    'ok)
```
- 这里的核心过程是`(add-action! input invert-input)`，它将调用`accept-action-procedure!`过程，如果按照题目的写法，则不能运行`invert-input`过程，所以过程`(after-delay inverter-delay (lambda () (set-signal! output new-value)))`也不能被执行，所以`(lambda ()  (set-signal! output new-value))`不能被加入`the-agenda`，所以不能这样。