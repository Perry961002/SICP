(load "Chap2\\example\\exa2.1.4-Interval-arithmetic.scm")
;定义减法运算
(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))))