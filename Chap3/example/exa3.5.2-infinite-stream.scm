;使用Racket，内置流的实现

;正整数流
(define (integers-starting-from n)
    (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;是否整除
(define (divisible? x y) (= (remainder x y) 0))

;厄拉多塞筛法
(define (sieve stream)
    (stream-cons
        (stream-car stream)
        (sieve (stream-filter
                (lambda (x)
                    (not (divisible? x (stream-car stream))))
                (stream-cdr stream)))))

;无穷的素数流
(define primes (sieve (integers-starting-from 2)))

;1的无穷流
(define ones (stream-cons 1 ones))

;两个给定流的逐对元素之和
(define (add-stream s1 s2)
    (stream-map + s1 s2))

;将给定的常数乘到流中的每个项上
(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))