;过程的复合定义
(define (compose f g)
    (lambda (x) (f (g x))))