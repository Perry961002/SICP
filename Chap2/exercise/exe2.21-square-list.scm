;返回每个数的平方构成的表
(define (square x) (* x x))
;定义1
(define (square-list items)
    (if (null? items)
        '()
        (cons (square (car items))
              (square-list (cdr items)))))

;第二种定义
(define (square-list items)
    (map (lambda (x) (* x x)) items))