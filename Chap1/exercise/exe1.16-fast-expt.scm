;求平方
(define (square x) (* x x))
;判断一个数是否是偶数
(define (even? n)
    (= (remainder n 2) 0))

;迭代法求幂, 附加一个状态变量, 并定义一个不变量,在状态转移时保持不变
;(fun b n a) := (fun b^2 n/2-1 a*b^2), if n 是偶数
;(fun b n a) := (fun b^2 n-1 a*b), if n 是奇数
(define (fast-expt b n)
    (define (fast-expt-iter b n a)
        (cond ((= n 0) a)
              ((even? n) (fast-expt-iter (square b) (- (/ n 2) 1) (* a (square b))))
              (else (fast-expt-iter b (- n 1) (* a b)))))
    (fast-expt-iter b n 1))