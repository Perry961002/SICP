;把a1一直提高到和a2相同类型，否则返回false
(define (raise-up a1 a2)
    (let ((type1 (type-tag a1))
          (type2 (type-tag a2)))
        (cond ((eq? type1 type2) a1)
              ((get 'raise type1)
               (raise-up (raise a1) a2))
              (else #f))))

;重写apply-generic过程
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (type-tag (car args)))
                          (type2 (type-tag (cadr args)))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (cond ((raise-up a1 a2)
                               (apply-generic op (raise-up a1 a2) a2))
                              ((raise-up a2 a1)
                               (apply-generic op a1 (raise-up a2 a1)))
                              (else
                                (error "No method for these types"
                                        (list op type-tags)))))
                    (else
                        (error "No method for these types"
                                (list op type-tags))))))))