(load "Chap3\\example\\exa3.5.1-stream-as-delay-table.scm")

(define sum 0)

(define (accum x)
    (set! sum (+ x sum))
    sum)

;(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; i   = 1  2  3  4   5   6   7   8   9   10  11  12  13  14   15   16   17   18   19   20
; seq = 1  3  6  10  15  21  28  36  45  55  66  78  91  105  120  136  153  171  190  210
; sum = 1

;(define y (stream-filter even? seq))
; sum = 6

;(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
; sum = 10

;(stream-ref y 7)
; 136

;(display-stream z)
; 10
;15
;45
;55
;105
;120
;190
;210'done