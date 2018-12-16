;使用两个改变函数和一个过程get-new-pair实现cons
(define (cons x y)
    (let ((new (get-new-pair)))
        (set-car! new x)
        (set-cdr! new y)
        new))
;---------------------------------------------
;共享和相等
(define (set-to-wow! x)
    (set-car! (car x) 'wow)
    x)