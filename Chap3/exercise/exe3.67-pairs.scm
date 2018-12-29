;混合进一个流，即(S1, T0), (S2, T0), ...
(define (pairs s t)
    (stream-cons 
        (list (stream-car s) (stream-cdr t))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) x))
                        (stream-cdr t))
            (interleave
                (stream-map (lambda (x) (list x (stream-car t)))
                            (stream-cdr s))
                (pairs (stream-cdr s) (stream-car t))))))

(display-top10 (pairs integers integers))
;(1 1)  (1 2)  (2 1)  (1 3)  (2 2)  (1 4)  (3 1)  (1 5)  (2 3)