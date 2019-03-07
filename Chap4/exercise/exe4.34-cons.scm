(define (cons a b)
    (list 'cons (lambda (m) (m x y))))

(define (cons? exp)
    (tagged-list? exp 'cons))

(define (cons-body exp)
    (cadr exp))

(define (car z)
    ((cons-body z) 
        (lambda (p q) p)))

(define (cdr z)
    ((cons-body z) 
        (lambda (p q) q)))

(define (print exp)
    (define (iter cur level)
        (if (null? cur)
            (display ")")
            (if (> level 20)
                (display "......)")
                (begin (display (car cur))
                       (display " ")
                       (iter (cdr cur) (+ level 1))))))
    (display "(")
    (iter exp 0))