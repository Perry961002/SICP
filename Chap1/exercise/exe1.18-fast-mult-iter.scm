;求一个数的两倍
(define (double x) (+ x x))

;判断一个数是不是偶数, 是的话返回true
(define (even? x) (= (remainder x 2) 0))

;将一个偶数除以2
(define (halve x) (/ x 2))

;迭代计算乘法
; (a b prod) := (a/2 2(b-1) prod+a), a是偶数
; (a b prod) := (a-1 b prod+b), a是奇数
(define (fast-mult-iter a b product)
    (cond ((= a 0) product)
          ((even? a) (fast-mult-iter (halve a)
                                     (double (- b 1))
                                     (+ product a)))
          (else (fast-mult-iter (- a 1)
                                b
                                (+ product b)))))

(define (fast-mult a b)
    (fast-mult-iter a b 0))