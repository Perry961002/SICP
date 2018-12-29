;首先我们描述一下(triples S T U)，也是将它分成三部分
;序对(S0, T0, U0)，第一个平面里面所有其他序对，其他序对
;对于第二部分的序对描述为(S0, Ti, Uj), i <= j, i >= 0, j >= 1
;第三部分为(triples Sr, Tr, Ur)
(define (triples s t u)
    (stream-cons
        (list (stream-car s) (stream-car t) (stream-car u))
        (interleave
            (stream-map (lambda (x) (cons (stream-car s) x))
                        (pairs t (stream-cdr u)))
            (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

;Pythagoras三元组
(define pythagoras
    (define (square x) (* x x))
    (stream-filter (lambda (x)
                        (= (+ (square (car x))
                              (square (cadr x)))
                           (square (caddr x))))
                   (triples integers integers integers)))
(display-top10 pythagoras)
;只能算这么多，后面溢出了
;(3 4 5)  (6 8 10)  (5 12 13)  (9 12 15)  (8 15 17)  (12 16 20) 
