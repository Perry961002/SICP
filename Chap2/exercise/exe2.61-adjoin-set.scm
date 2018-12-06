;重写对于有序集合的adjoin-set操作
(define (adjoin-set x set)
    (if (null? set)
        (cons x set)
        (let ((y (car set)))
            (cond ((= x y) set)
                  ((< x y) (cons x set))
                  (else (cons y
                              (adjoin-set x (cdr set))))))))