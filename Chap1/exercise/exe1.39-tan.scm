;k项有限连分式过程
(load "Chap1\\exercise\\exe1.37-cont-frac.scm")
(define (square x) (* x x))
(define (tan-cf x k)
    (define (N i)
        (if (= i 1)
            x
            (- (square x))))
    (define (D i)
        (- (* i 2) 1))
    (cont-frac-iter N D k))