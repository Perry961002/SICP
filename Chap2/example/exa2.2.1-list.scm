(define one-through-four (list 1 2 3 4))
(car one-through-four)
(cdr one-through-four)
(cons 0 one-through-four)
(cons one-through-four 5)
;----------------------------------------
;返回表的第n个项, scheme已经定义这个过程
(define (list-ref items n)
    (cond ((null? items) (display "error: list is null"))
          ((= n 0) (car items))
          (else (list-ref (cdr items) (- n 1)))))

;返回表的长度, scheme已经定义
(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))

;合并两个表, scheme已经定义
(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

;对表的映射map, scheme已经定义
(define (map proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (cdr items)))))