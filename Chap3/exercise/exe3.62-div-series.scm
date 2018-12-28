; 假设X= S1 / S2
; X = S1 * (1 / (S2 / c)) * (1 / c)  (c是S2的常数项)

(define (div-series s1 s2)
    (let ((c (stream-car s2)))
        (if (= c 0)
            (error "The series in the denominator has 0! constant terms")
            (scale-stream (mul-series s1
                                      (reciprocal-series (scale-stream s2 (/ 1 c))))
                          (/ 1 c)))))
                
(define tan-series (div-series sine-series cosine-series))
;(display-top10 tan-series)
;0  1  0  1/3  0  2/15  0  17/315  0 