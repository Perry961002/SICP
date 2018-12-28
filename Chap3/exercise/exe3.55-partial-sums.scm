(define (partial-sum s)
    (define res
        (stream-cons (stream-car s)
                     (stream-map + res (stream-cdr s))))
    res)