(define (install-polynomial-package)
    ;构造函数
    (define (make-poly variable term-list)
        (cons variable term-list))

    ;选择函数
    (define (variable p) (car p))

    (define (term-list p) (cdr p))

    ;x是不是符号
    (define (variable? x) (symbol? x))

    ;v1和v2两个符号是否相同
    (define (same-variable? v1 v2)
        (and (variable? v1) (variable? v2) (eq? v1 v2)))

    ;两个代数式相加
    (define (add-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1)
                       (add-terms (term-list p1)
                                  (term-list p2)))
            (error "Polys not in same var -- ADD-POLY" (list p1 p2))))

    ;两个代数式相乘
    (define (mul-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1)
                       (mul-terms (term-list p1)
                                  (term-list p2)))
            (error "Poly not in same var -- MUL-POLY" (list p1 p2))))

    ;从两个需要求和的多项式构造起一个项表
    (define (add-terms L1 L2)
        (cond ((empty-termlist? L1) L2)
              ((empty-termlist? L2) L1)
              (else
                (let ((t1 (first-term L1)) (t2 (first-term L2)))
                    (cond ((> (order t1) (order t2))
                           (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                          ((< (order t1) (order t2))
                           (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                          (else
                            (adjoin-term
                                (make-term (order t1)
                                           (add (coeff t1) (coeff t2)))
                                (make-term (rest-terms L1)
                                           (rest-terms L2)))))))))
    
    ;两个项表相乘
    (define (mul-terms L1 L2)
        (if (empty-termlist? L1)
            (the-empty-termlist)
            (add-terms (mul-term-by-all-terms (first-term L1) L2)
                       (mul-terms (rest-terms L1) L2))))
    (define (mul-term-by-all-terms t1 L)
        (if (empty-termlist? L)
            (the-empty-termlist)
            (let ((t2 (first-term L)))
                (adjoin-term
                    (make-term (+ (order t1) (order t2))
                               (mul (coeff t1) (coeff t2)))
                    (mul-term-by-all-terms t1 (rest-terms L))))))

    ;加入项表
    (define (adjoin-term term term-list)
        (if (=zero? (coeff term))
            term-list
            (cons term term-list)))

    ;定义空表
    (define (the-empty-termlist) '())

    ;返回项表的最高次项
    (define (first-term term-list) (car term-list))

    ;返回除最高次项的其他项
    (define (rest-terms term-list) (cdr term-list))

    ;是否为空
    (define (empty-termlist? term-list) (null? term-list))

    ;构造项
    (define (make-term order coeff) (list order coeff))

    ;取得次数
    (define (order term) (car term))

    ;取得系数
    (define (coeff term) (cadr term))

    ;定义接口
    (define (tag p) (attach-tag 'polynomial p))

    (put 'add '(polynomial polynomial)
        (lambda (p1 p2) (tag (add-poly p1 p2))))

    (put 'mul '(polynomial polynomial)
        (lambda (p1 p2) (tag p1 p2)))

    (put 'make 'polynomial
        (lambda (var terms) (tag (make-poly var terms))))
    'done)