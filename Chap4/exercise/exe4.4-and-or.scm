(define (and-clauses exp) (cdr exp)) 
(define (or-clauses exp) (cdr exp)) 
(define (first-exp seq) (car seq)) 
(define (rest-exps seq) (cdr seq)) 
(define (empty-exp? seq) (null? seq)) 
(define (last-exp? seq) (null? (cdr seq))

(define (eval-and exps env)
    (if (empty-exp? exps)
        '#t
        (let ((first (eval (first-exp exps) env)))
            (if (false? first)
                '#f
                (eval-and (rest-exps exps) env)))))

(define (eval-or exps env)
    (if (empty-exp? exps)
        '#f
        (let ((first (eval (first-exp exps) env)))
            (if (true? first)
                '#t
                (eval-or (rest-exps exps) env)))))
;-----------------------------------------------------
;定义为派生表达式
;考虑把and和or用嵌套的if来实现