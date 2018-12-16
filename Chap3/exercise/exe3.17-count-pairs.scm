(define already-visit '())

(define (visited? pair)
    (define (iter pairs)
        (if (null? pairs)
            #f
            (or (eq? pair (car pairs))
                (iter (cdr pairs)))))
    (iter already-visit))
    
(define (count-pairs x)
    (cond ((not (pair? x)) 0)
          ((visited? x) 0)
          (else
            (begin (set! already-visit (cons x already-visit))
                   (+ (count-pairs (car x))
                      (count-pairs (cdr x))
                      1)))))

(define p3 (cons 3 '()))
(define p2 (cons 2 p3))
(define p1 (cons 1 p2))
(display (count-pairs p1)) ; ==> 3

(define q3 (cons 'b '()))
(define q2 (cons 'a q3))
(define q1 (cons q2 q3))
(newline)
(display (count-pairs q1)) ; ==> 3

(define r3 (cons 'r '()))
(define r2 (cons r3 r3))
(define r1 (cons r2 r2))
(newline)
(display (count-pairs r1)) ; ==> 3

(define w3 (cons '() '()))
(define w2 (cons 'w w3))
(define w1 (cons w2 '()))
(set-car! w3 w1)
(newline)
(display (count-pairs w1)) ; ==> 3