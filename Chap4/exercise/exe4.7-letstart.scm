;判断函数
(define (let*? exp)
    (taggesd-list exp 'let*))

;利用let进行派生
(define (expand-let bindings body)
    (if (null? bindings)
        body
        (make-let (list (car bindings))
                  (expand-let (cdr bindings) body))))

(define (let*->nested-lets exp)
    (expand-let (let-bindings exp)
                (let-body exp)))