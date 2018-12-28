; X = 1 - Sr * X
(define (reciprocal-series s)
    (stream-cons 1
                 (mul-series (scale-stream (stream-cdr s) -1)
                             (reciprocal-series s))))

;(display-top10 (mul-series exp-series (reciprocal-series exp-series)))
;1  0  0  0  0  0  0  0  0  