;使用两个改变函数和一个过程get-new-pair实现cons
(define (cons x y)
    (let ((new (get-new-pair)))
        (set-car! new x)
        (set-cdr! new y)
        new))
;---------------------------------------------
;共享和相等
(define (set-to-wow! x)
    (set-car! (car x) 'wow)
    x)
;---------------------------------------------
;改变也是赋值

;重写cons
(define (cons x y)
    (define (set-x! v) (set! x v))
    (define (set-y! v) (set! y v))
    (define (dispatch m)
        (cond ((eq? m 'car) x)
              ((eq? m 'cdr) y)
              ((eq? m 'set-car!) set-x!)
              ((eq? m 'set-cdr!) set-y!)
              (else (error "Undefined operation -- CONS" m))))
    dispatch)

(define (car z) (z 'car))
(define (cdr z) (z 'cdr))
(define (set-car! z new-value)
    ((z 'set-car!) new-value)
    z)
(define (set-cdr! z new-value)
    ((z 'set-cdr!) new-value)
    z)