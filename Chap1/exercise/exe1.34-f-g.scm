(define (f g)
    (g 2))

;(f (lambda (z) (* z (+ z 1))))
;==> ((lambda (z) (* z (+ z 1))) 2)
;==> 6

;(f f)
;==> (f 2)
;2不是一个过程, 所以会报错