(define (double f)
    (lambda (x) (f (f x))))
;(define (inc x) (+ x 1))
;double f*2
;(double double) f*4
;(double (double double)) f*16

;(((double (double double)) inc) 5) = 21