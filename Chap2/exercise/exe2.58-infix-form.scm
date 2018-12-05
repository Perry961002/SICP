(load "Chap2\\example\\exa2.3.2-Symbolic-guidance.scm")
(load "Chap2\\example\\exa2.3.1-quotation.scm")

; a)
;重写过程make-sum, 返回 (a1 + a2)
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list a1 '+ a2))))

;重写过程sum?，表中第二个元素是+符号就是和式
(define (sum? x)
    (and (pair? x) (eq? (cadr x) '+)))

;重写过程addend,表中第一个元素就是被加数
(define (addend s) (car s))

;重写过程augend，表中第三个元素就是加数
(define (augend s) (caddr s))

;重写过程make-product，返回 (m1 * m2)
(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 '* m2))))

;重写过程product?，表中第二个元素是*符号就是乘式
(define (product? x)
    (and (pair? x) (eq? (cadr x) '*)))

;重写过程multipliter，表中第一个元素就是被乘数
(define (multipliter p) (car p))

;重写过程multiplicand，表中的第三个元素就是乘数
(define (multiplicand p) (caddr p))

; b)
;对于标准写法，先做加法再把结果做乘法的情况必须加括号，对于其他情况就是把操作符两边的表达式取出再补括号

;判断总的算式类型，即在列表中出现的第一个操作符
(define (main-oper s)
    (if (memg '+ s)
        '+
        '*))

;算式是不是和式，即主操作符是不是+号
(define (sum? s)
    (eq? (main-oper s) '+))

;取出被加数，即+号之前的部分
(define (addend s)
    (define (iter result items)
        (if (eq? (car items) '+)
            result
            (iter (append result (list (car items))) (cdr items))))
    (let ((res (iter '() s)))
        (if (null? (cdr res))
            (car res)
            res)))

;取出加数，即+号之后的部分，即(memg '+ s)的cdr部分
(define (augend s)
    (let ((res (cdr (memg '+ s))))
        (if (null? (cdr res))
            (car res)
            res)))

;算式是不是乘式，即主操作符是不是*号
(define (product? p)
    (eq? (main-oper p) '*))

;取出被乘数，即*号之前的部分
(define (multipliter s)
    (define (iter result items)
        (if (eq? (car items) '*)
            result
            (iter (append result (list (car items))) (cdr items))))
    (let ((res (iter '() s)))
        (if (null? (cdr res))
            (car res)
            res)))

;取出加数，即+号之后的部分，即(memg '+ s)的cdr部分
(define (multiplicand s)
    (let ((res (cdr (memg '* s))))
        (if (null? (cdr res))
            (car res)
            res)))