(define already-visit '())

(define (visited? pair)
    (define (iter pairs)
        (if (null? pairs)
            #f
            (or (eq? pair (car pairs))
                (iter (cdr pairs)))))
    (iter already-visit))

(define (have-cycle? x)
    (cond ((not (pair? x)) #f)
          ((visited? x) #t)
          (else
            (begin (set! already-visit (cons x already-visit))
                   (or (have-cycle? (car x))
                       (have-cycle? (cdr x)))))))