(load "Chap3\\example\\exa3.5.1-stream-as-delay-table.scm")

(define (show x)
    (display-line x)
    x)

(define x (stream-map show (stream-enumerate-interval 0 10)))
;0
;Value: x
(stream-ref x 5)
;1
;2
;3
;4
;5
;Value: 5
(stream-ref x 7)
;6
;7
;Value: 7