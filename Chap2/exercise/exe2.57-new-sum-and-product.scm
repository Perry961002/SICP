(load "Chap2\\exercise\\exe2.56-exponentiation.scm")

;重新定义make-sum过程,接受参数列表, 并整合成一个和式
(define (make-sum . items)
    (define (iter result x)
        (if (null? x)
            result
            (let ((first (car x)))
                (if (=number? first 0)
                    (iter result (cdr x))
                    (iter (append result (list first))
                          (cdr x))))))
    (let ((add (iter '() items)))
        (if (null? (cdr add))
            (car add)
            (append '(+) add))))

;重新定义过程augend，得到和式中除了被加数的其余项
(define (augend s)
    (if (null? (cdddr s))
        (caddr s)
        (append '(+) (cddr s))))

;重新定义过程make-product, 接受参数列表, 并整合成一个乘式
(define (make-product . items)
    (define (iter result x)
        (if (null? x)
            result
            (let ((first (car x)))
                (cond ((=number? first 0) (list 0))
                      ((=number? first 1)
                       (iter result (cdr x)))
                      (else (iter (append result (list first))
                                  (cdr x)))))))
    (let ((mul (iter '() items)))
        (if (null? (cdr mul))
            (car mul)
            (append '(*) mul))))

;重写过程multiplicand,得到乘式中除了被乘数的其余项
(define (multiplicand s)
    (if (null? (cdddr s))
        (caddr s)
        (append '(*) (cddr s))))