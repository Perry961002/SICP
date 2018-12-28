; a)

;幂级数的积分
(define (integrate-series s)
    (stream-map / s integers))

;e^x的级数
(define exp-series
    (stream-cons 1 (integrate-series exp-series)))
;(display-top10 exp-series)
;1  1  1/2  1/6  1/24  1/120  1/720  1/5040  1/40320 

;(sin x)' = cos x, (cos x)' = -sin x
;所以cos x的级数就是-sin x级数的积分，sin x的级数就是cos x级数的积分
(define cosine-series
    (stream-cons 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
    (stream-cons 0 (integrate-series cosine-series)))

;(display-top10 cosine-series)
;1  0  -1/2  0  1/24  0  -1/720  0  1/40320

;(display-top10 sine-series)
;0  1  0  -1/6  0  1/120  0  -1/5040  0