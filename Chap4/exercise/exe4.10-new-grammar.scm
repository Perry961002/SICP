;之前都是用的前缀式，这里不妨考虑一下后缀式
;如 (1 2 3 +) 结果就是6

;简单的修改过程
(define (last-list l)
    (if (null? (cdr l))
        (car l)
        (last-list (cdr l))))

(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (last-list exp) tag)
        #f))

;下面就是对一些选择函数进行更改，这里不再给出代码