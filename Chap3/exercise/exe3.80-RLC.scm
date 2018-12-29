(define (RLC R L C dt)
    (lambda (vc0 iL0)
        (define vc (integral (delay dvc) vc0 dt))
        (define iL (integral (delay diL) iL0 dt))
        (define dvc (scale-stream iL (/ -1.0 C)))
        (define diL (add-streams (scale-stream iL (- (/ R L)))
                                 (scale-stream vc (/ 1.0 L))))
        (cons vc iL)))

(define RLC1 ((RLC 1 1 0.2 0.1) 10 0))

(define RLC1-vc (car RLC1))
(define RLC-iL (cadr RLC1))

(display-top10 RLC1-vc)
(newline)
(display-top10 RLC-iL)

;10  10  9.5  8.55  7.220000000000001  5.5955  3.77245  1.8519299999999999  -0.0651605000000004  
;0  1.0  1.9  2.66  3.249  3.6461  3.84104  3.834181  3.6359559  