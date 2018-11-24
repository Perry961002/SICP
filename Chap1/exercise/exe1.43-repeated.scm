(load "Chap1\\exercise\\exe1.42-compose.scm")

;f的n次重复应用
(define (repeated f n)
    (if (= n 1)
        (lambda (x) (f x)) ;n=1, 返回过程f(x)
        (lambda (x)
            ((compose f (repeated f (- n 1)))  ;返回过程 ((compose f (repeated f n-1)) x)
             x))))