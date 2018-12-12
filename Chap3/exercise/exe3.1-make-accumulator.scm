;创建一个累加器
(define (make-accumulator num)
    (lambda (x)
            (set! num (+ num x))
            num))

;测试
;(define A (make-accumulator 5))
;(A 20) ==> 25
;(A 5) ==> 30
;(define B (make-accumulator 10))
;(B 20) ==> 30