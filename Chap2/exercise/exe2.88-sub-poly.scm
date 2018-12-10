(define (install-polynomial-package)
    ;...
    (define (sub-terms L1 L2)
        (cond ((empty-termlist? L2) L1)
              ((empty-termlist? L1) (mul-terms (make-term 0 -1) L2))
              (else
                (let ((t1 (first-term L1)) (t2 (first-term L2)))
                    (cond ((> (order t1) (order t2))
                           (adjoin-term t1
                                        (sub-terms (rest-terms L1) L2)))
                          ((< (order t1) (order t2))
                           (adjoin-term
                                (mul-terms (make-term 0 -1) t2)
                                (sub-terms L1 (rest-terms L2))))
                          (else
                            (adjoin-term 
                                (make-term (order t1)
                                           (sub (coeff t1) (coeff t2)))
                                (sub-terms (rest-terms L1)
                                           (rest-terms L2)))))))))

    (define (sub-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1)
                       (sub-terms (term-list p1)
                                  (term-list p2)))
            (error "Poly not in same var -- SUB-POLY"
                    (list p1 p2))))
    'done)