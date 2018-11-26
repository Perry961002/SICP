(load "Chap2\\exercise\\exe2.7-make-interval.scm")

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i))
       2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i))
        2))
;----------------------------------------------------
;习题
;构造函数
(define (make-center-percent c p)
    (make-interval (- c (* c p))
                   (+ c (* c p))))

;选择函数percent
(define (percent i)
    (/ (+ (lower-bound i) (upper-bound i))
       (- (upper-bound i) (lower-bound i))))