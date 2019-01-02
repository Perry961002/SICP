(load "Chap3\\example\\exa3.3.3-table.scm")
(load "Chap4\\example\\exa4.1.2-expression.scm")
(load "Chap4\\example\\exa4.1.1-eval-apply.scm")
(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc!))

;通过对几个判断过程的分析发现，下面的几个过程都会用到tagged-list?，即有没有tag标志
;它们可以安装到求值器
(put 'eval 'quote text-of-quotation)

(put 'eval 'set! eval-assignment)

(put 'eval 'define eval-definition)

(put 'eval 'if eval-if)

(put 'eval 'lambda (lambda (x y)
                        (make-procedure (lambda-parameters x)
                                        (lambda-body x)
                                        y)))

(put 'eval 'begin (lambda (x y)
                    (eval-sequence (begin-actions x) y)))

(put 'eval 'cond (lambda (x y) (eval (cond->if x) y)))

(define (eval exp env)
    (cond ((self-envaluating? exp) exp)
          ((variable? exp) (look-variable-value exp env))
          ((get 'eval (car exp))
           ((get 'eval (car exp)) exp env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else 
            (error "Unknown expression type -- EVAL" exp))))