(define (square x) (* x x))
;判断a是否是b的因子
(define (divides? a b)
    (= (remainder b a) 0))

;发现从test-divisor开始的n的第一个因子
(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

;找到n的最小的一个因子
(define (smallest-divisor n)
    (find-divisor n 2))

;判断n是不是素数,是的话他的最小因子就是他本身
(define (prime? n)
    (= (smallest-divisor n) n))
;--------------------------------------------------------------------------
(define (even? x) (= (remainder x 2) 0))
;计算base^exp mod m
(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                       m))))

;从0到n-1之间随机选择数a进行费马检查,检查a^n mod n =? a
(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

;按times给定的次数对n进行检查,如果每次检查都成功,那么这一过程的值就是真
(define (fast-prime? n times)
    (cond ((= times 0) #t)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else #f)))