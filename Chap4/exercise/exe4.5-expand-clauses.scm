;对于书中提出的子句 (<test> => <recipient>)，它的判断过程应该是第三个元素是不是 =>
;如果<test>为真，返回一个过程，参数为<test>，过程体是对<recipient>的求值

(define (cond-extended-clause? clause)
    (eq? (cadr (cond-actions clause)) '=>))

(define (cond-recipient clause) 
    (caddr clause))

(define (expand-clauses clauses)
    (if (null? clauses)
        '#f
        (let ((first (car clauses))
              (rest (cdr clauses)))
            (if (cond-else-clause? first)
                (if (null? rest)
                    (sequence->exp (cond-actions first))
                    (error "ELSE clause isn't last -- COND->IF" clauses))
                (if (cond-extended-clause? first)
                    (make-if (cond-predicate first)
                             (make-lambda (cond-predicate first) (cond-recipient first))
                             (expand-clauses rest))
                    (make-if (cond-predicate first)
                             (sequence->exp (cond-actions first))
                             (expand-clauses rest)))))))