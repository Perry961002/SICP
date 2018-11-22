;求一个数的两倍
(define (double x) (+ x x))

;判断一个数是不是偶数, 是的话返回true
(define (even? x) (= (remainder x 2) 0))

;将一个偶数除以2
(define (halve x) (/ x 2))

;快速乘法
(define (fast-mult a b)
    (cond ((= a 0) 0)
          ((even? a) (double (fast-mult (halve a) b)))
          (else (+ b (fast-mult (- a 1) b)))))