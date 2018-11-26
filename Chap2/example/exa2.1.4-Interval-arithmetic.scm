(load "Chap2\\exercise\\exe2.7-make-interval.scm")
;区间加法运算
(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y)
                   (+ (upper-bound x) (upper-bound y)))))
;乘法运算
(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))
;除法运算
(define (div-interval x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))