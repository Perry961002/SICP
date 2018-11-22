;欧几里得算法
(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))