;修改之后可以打印近似值序列的fixed-point过程
(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) 0.00001))
    (define (try guess)
        (let ((next (f guess)))
            (newline)
            (display guess)
            (if (close-enough? guess next)
                (begin (newline)
                       (display "Result:")
                       (display next))
                (try next))))
    (try first-guess))

;不用平均阻尼
(define not-average 
    (begin (display "No average damping:")
           (fixed-point (lambda (x) (/ (log 1000) (log x))) 4.0)
           (display "\n\n")))

;使用平均阻尼, 根据运行结果发现会快很多
(define not-average 
    (begin (display "Use average damping:")
           (fixed-point (lambda (x) (/ (+ x 
                                          (/ (log 1000) (log x)))
                                       2)) 4.0)))