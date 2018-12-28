;级数乘积
; (a0,a1,a2,a3,...)*(b0,b1,b2,b3,...)
; = (a0,a.rest)*(b0,b.rest)  ;(a.rest表示第一项往后的所有数)
; = (a0*b0, (a0*b.rest + b0*a.rest + a.rest*b.rest))  ;注意a0*b.rest 和 b0*a.rest的最低次数比a.rest*b.rest的最低次数要小一
(define (mul-series s1 s2)
    (stream-cons (* (stream-car s1) (stream-car s2))
                 (add-streams
                    (add-streams (scale-stream (stream-cdr s2) (stream-car s1))
                                 (scale-stream (stream-cdr s1) (stream-car s2)))
                    (stream-cons 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))  ;最前面要补0

;(display-top10 (add-streams (mul-series sine-series sine-series)
;                            (mul-series cosine-series cosine-series)))
;1  0  0  0  0  0  0  0  0  