(load "Chap2\\example\\exa2.3.3-set.scm")

;合并两个集合操作
(define (union-set set1 set2)
    (if (null? set1)
        set2
        (union-set (cdr set1) (adjoin-set (car set1) set2))))