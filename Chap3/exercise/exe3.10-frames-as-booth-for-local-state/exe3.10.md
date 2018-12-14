- 用lambda表达式改写make-withdraw过程

```
(define make-withdraw
    (lambda (initial-amount)
        ((lambda (balance)
            (lambda (amount)
                (if (>= balance amount)
                    (begin (set! balance (- balance amount))
                           balance)
                    "Insufficient funds")))
         initial-amount)))
```

- 定义make-withdraw

<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.10-frames-as-booth-for-local-state/a.jpg" alt="a"/>
</p>

- 调用(define w1 (make-withdraw 100))

<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.10-frames-as-booth-for-local-state/b.jpg" alt="b"/>
</p>

- 调用(w1 50)

<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.10-frames-as-booth-for-local-state/c.jpg" alt="c"/>
</p>

- 调用(define w2 (make-withdraw 100))

<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.10-frames-as-booth-for-local-state/d.jpg" alt="d"/>
</p>