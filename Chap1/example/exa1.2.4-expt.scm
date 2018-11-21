;求平方
(define (square x) (* x x))
;判断一个数是否是偶数
(define (even? n)
    (= (remainder n 2) 0))

;利用连续平方和求幂
; b^n = (b^(n/2))^2
; b^n = b * b^(n-1)
(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))