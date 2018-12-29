;两个流相加
(define (add-streams s1 s2)
    (stream-map + s1 s2))

;积分器
(define (integral integrand initial-value dt)
    (define int
        (stream-cons initial-value
                     (add-streams (scale-stream integrand dt)
                                  int)))
    int)

;RC电路模拟器
(define (RC R C dt)
    (lambda (current v0)
        (add-streams (scale-stream current R)
                     (integral (scale-stream current (/ 1.0 C)) 
                               v0 dt))))

;求值题目要求的条件的电路
(define RC1 (RC 5 1 0.5))

(display-top10 (RC1 integers 1))
;6  11.5  17.5  24.0  31.0  38.5  46.5  55.0  64.0 