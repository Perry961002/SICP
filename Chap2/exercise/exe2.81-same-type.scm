(load "Chap3\\example\\exa3.3.3-table.scm")
;补充定义：
(define coercion-table (make-table))
(define get-conercion (operation-table 'lookup-proc))
(define put-conercion (operation-table 'insert-proc!))
(load "Chap2\\example\\exa2.5.2-combination-of-data-types.scm") ;apply-generic过程

;补充Louis定义的过程
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-conercion 'scheme-number 'scheme-number
                scheme-number->scheme-number)
(put-conercion 'complex 'complex complex->complex)

; a)
;对于两个复数的运算，在apply-generic的定义中我们发现在复数的程序包里找不到求幂的过程
;所以会进行类型转换，因为存在从复数到复数的类型转换，所以会陷入一个死循环

; b)
;从a小问可以知道一旦存在没有实现的通用操作，程序会陷入死循环

; c)
;加入一个对类型名是否相等判断即可
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags)))
                        (if (eq? type1 type2)
                            (error "No method for these types" (list op type-tags))
                            (let ((a1 (car args))
                                  (a2 (cadr args))
                                  (t1->t2 (get-conercion type1 type2))
                                  (t2->t1 (get-conercion type2 type1)))
                                (cond (t1->t2
                                        (apply-generic op (t1->t2 a1) a2))
                                      (t2->t1
                                        (apply-generic op a1 (t2->t1 a2)))
                                      (else
                                        (error "No method for these types"
                                               (list op type-tags)))))))
                    (else
                        (error "No method for these types"
                                (list op type-tags))))))))