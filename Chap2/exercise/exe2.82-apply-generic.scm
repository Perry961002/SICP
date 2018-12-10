(load "Chap3\\example\\exa3.3.3-table.scm")
;补充定义：
(define coercion-table (make-table))
(define get-coercion (operation-table 'lookup-proc))
(define put-coercion (operation-table 'insert-proc!))

(define (apply-generic op . args)
    ;将列表里的参数类型都转换为类型target
    (define (coercion-list lst target)
        (map (lambda (x)
                (let ((proc (get-coercion (type-tag x) target)))
                    (if proc
                        (proc x)
                        x)))
             lst))
    ;应用于参数列表
    (define (apply-types-list lst)
        (if (null? lst)
            (error "No method for these types")
            (let ((coerced-list (coercion-list args (type-tag (car lst)))))
                (let ((proc (get op (map type-tag coerced-list))))
                    (if proc
                        (apply proc (map contents coerced-list))
                        (apply-types-list (cdr lst)))))))

    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (apply-types-list args))))
    )