;将树变换为表
(load "Chap2\\example\\exa2.3.3-set.scm")

;方法一
(define (tree->list-1 tree)
    (if (null? tree)
        '()
        (append (tree->list-1 (left-branch tree))
                (cons (entry tree)
                      (tree->list-1 (right-branch tree))))))

;方法二
(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list)))))
    (copy-to-list tree '()))
                    
;测试用例
;(define tree (list 7 (list 3 (list 1 '() '()) (list 5 '() '())) (list 9 '() (list 11 '() '()))))
;(tree->list-1 tree) ==> (1 3 5 7 9 11)
;(tree->list-1 tree) ==> (1 3 5 7 9 11)

; a)
;两个的结果一样，对于tree->list-1，很明显的就是左-根-右的顺序
;对于tree->list-2，访问顺序是根-右-左，但根据copy-to-list里的组合顺序，得到的还是左-根-右

; b)
;因为cons的效率比append的效率高，所以tree->list-2的速度更快