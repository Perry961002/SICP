;强制：不同的数据类型通常都不是完全相互无关的；通常存在一些方式，是我们可以把一种类型的对象看做是另一种类型的对象

;检查强制表格，查看其中第一个参数类型的对象能否转换到第二个参数的类型。
;如果可以，那么那么就对第一个参数做强之后再实验操作。
;如果第一个参数的类型不能强制到第二个类型，那么就试验另一种方式
;最后，如果不存在从一个类型到另一种类型的转换的强制，那么就只能放弃了
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contens args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (let ((t1->t2 (get-coercion type1 type2))
                              (t2->t1 (get-coercion type2 type1)))
                            (cond (t1->t2
                                    (apply-generic op (t1->t2 a1) a2))
                                  (t2->t1
                                    (apply-generic op a1 (t2->t1 a2)))
                                  (else
                                    (error "No method for these types"
                                           (list op type-tags))))))
                    (error "No method for these types"
                            (list op type-tags))))))