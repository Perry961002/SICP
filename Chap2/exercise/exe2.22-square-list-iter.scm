;首先第一种方法不对是因为把新的数加在了之前结果的前面
;所以输出的是倒叙

;第二张方法不对是因为cons的第一个参数是表, 第二个是数, 得到的应该是一个序对

;写一个正确的迭代版本

(define (square x) (* x x))

(define (square-list items)
    (define (link x y) ;把x接到y后面
        (append x (list y)))
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (link answer (square (car things))))))
    (iter items '()))