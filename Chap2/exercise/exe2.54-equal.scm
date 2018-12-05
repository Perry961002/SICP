;a和b是equal?的：
;如果他们都是符号, 而且是eq?；
;或者他们都是表，而且(car a)和(cdr b)相互equal?, 他们的(cdr a)和(cdr b)也是equal?

(define (equal? a b)
    (cond ((and (not (pair? a)) (not (pair? b)))
            (eq? a b))
          ((and (pair? a) (pair? b))
            (and (equal? (car a) (car b)) (equal? (cdr a) (cdr b))))
          (else
            #f)))