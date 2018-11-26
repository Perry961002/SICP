(load "Chap2\\example\\exa2.1.4-Interval-arithmetic.scm")
(define (div-interval x y)
    (if (> 0 (* (lower-bound y) (upper-bound y)))
        (display "error")
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y))))))