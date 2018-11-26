(load "Chap2\\exercise\\exe2.7-make-interval.scm")
(define (width-interval x)
    (/ (- (upper-bound x) (lower-interval x))
       2.0))
;证明:
;区间 x: (a, b) = (a, a+2*x.width) , y: (c, d)(c, c+2*y.width)
; x + y = (a, b) + (c, d) = (a+c, b+d)
; (x+y).width = ((b+d) - (a+c)) / 2.0 = x.width + y.width