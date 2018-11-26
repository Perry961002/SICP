(define (reverse items)
    (if (= 1 (length items))
        items
        (append (reverse (cdr items)) (list (car items)))))