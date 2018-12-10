;用被除式的最高次项除以除式的最高次项，得到商式的第一项；而后用这个结果乘以除式，并从被除式中减去这个乘积
(define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
            (if (> (order t2) (order t1))
                (list (the-empty-termlist) L1)
                (let ((new-c (div (coeff t1) (coeff t2)))
                      (new-o (- (order t1) (order t2))))
                    (let ((rest-result
                            (div-terms (sub-terms L1
                                                  (mul-terms (list (make-term new-o new-c))
                                                             L2))
                                        L2)))
                        (list (adjoin-term (make-term new-o new-c)
                                           (car rest-result))
                              (cadr rest-result))))))))
            
(define (div-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (let ((result (div-terms (term-list p1)
                                 (term-list p2))))
            (list (make-poly (variable p1) (car result)) (cadr result)))
        (error
            "Polys not in same var -- DIV-POLY" 
            (list p1 p2))))