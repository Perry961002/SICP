;对于书上的解释，对(let <var> <bindings> <body>)
;body其实就是var的过程体，参数就是bindings
;即先把var定义为以bindings中的vars为参数、以body为过程体的过程
;然后以bindings里的values为实际参数调用过程var

(define (named-let? exp)
    (and (taggesd-list exp 'let)
         (eq? (length exp) 4)))

(define (named-let-var exp)
    (cadr exp))

(define (named-let-bindings exp)
    (caddr exp))

(define (named-let-bindings-vars exp)
    (map car (named-let-bindings exp)))

(define (named-let-bindings-values exp)
    (map cdr (named-let-bindings exp)))

(define (named-let-body exp)
    (cdddr exp))

;根据分析改写let-combination，加入判断即可
(define (let-combination exp)
    (cond ((named-let? exp)
            (list 'define (named-let-var exp)
                          (make-lambda (named-let-bindings-vars exp)
                                       (named-let-body exp)))
            (cons (named-let-var exp) (named-let-bindings-values exp)))
          (else
            (cons (make-lambda (let-vars exp) (let-body exp))
                  (let-exps exp)))))