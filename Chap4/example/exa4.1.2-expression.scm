;自求值表达式只有数和字符串
(define (self-evaluating? exp)
    (cond ((number? exp) #t)
          ((string? exp) #t)
          (else #f)))

;变量用符号表示
(define (variable? exp) (symbol? exp))

;引号表达式
(define (quoted? exp)
    (tagged-list? exp 'quote))
;引号后面的内容
(define (text-of-quotation exp) (cadr exp))
;确定表达式的开始是不是某个给定符号
(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        #f))

;赋值
(define (assignment? exp)
    (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))

(define (assignment-value exp) (caddr exp))

;定义
(define (definition? exp)
    (tagged-list? exp 'define))

(define (definition-variable exp)
    (if (symbol? (cadr exp))
        (cadr exp)
        (caddr exp)))

(define (definition-value exp)
    (if (symbol? (cadr exp))
        (caddr exp)
        (make-lambda (cdadr exp) ;参数
                     (cddr exp)))) ;过程体

;lambda表达式
(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))
;lambda表达式的构造函数
(define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))

;if条件式,一个谓词部分，一个推论部分，和一个(可缺的)替代部分
(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
    (if (not (null? (cdddr exp)))
        (cadddr exp)
        '#f))
;构造函数
(define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

;begin表达式
(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? seq) (null? (cdr seq)))

(define (first-exp seq) (car seq))

(define (rest-exps seq) (cdr seq))
;构造函数sequence->exp,把一个序列变换为一个表达式
(define (sequence->exp seq)
    (cond ((null? seq) seq)
          ((last-exp? seq) (first-exp seq))
          (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))

;过程应用，不属于上述各种表达式类型的任意复合表达式
(define (application? exp) (pair? exp))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))

(define (first-operand ops) (car ops))

(define (rest-operands ops) (cdr ops))
;-----------------------------------------------------
;派生表达式
(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
    (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
    (if (null? clauses)
        '#f
        (let ((first (car clauses))
              (rest (cdr clauses)))
            (if (cond-else-clause? first)
                (if (null? rest)
                    (sequence->exp (cond-actions first))
                    (error "ELSE clause isn't last -- COND->IF"
                            clauses))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest))))))