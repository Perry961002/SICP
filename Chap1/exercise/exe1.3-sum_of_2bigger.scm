;find smaller of a, b
(define (min a b) 
    (if (< a b)
        a
        b))
;subtract the smallest from the sum of three numbers
(define (sum a b c)
    (- (+ a b c) 
        (min (min a b) c)))