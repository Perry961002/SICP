(define (integers-starting-from n)
    (stream-cons n (integers-starting-from (+ n 1))))

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define factorials (stream-cons 1 (mul-streams factorials (integers-starting-from 2))))