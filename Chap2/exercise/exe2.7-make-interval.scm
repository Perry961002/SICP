;区间构造符的定义
(define (make-interval a b)
    (cons a b))
;定义选择符、
(define (lower-bound x)
    (car x))
(define (upper-bound x)
    (cdr x))