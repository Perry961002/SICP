;对于可重复的集合，操作element-of-set?和intersection-set不变

;重写adjoin-set, 复杂度由O(n)变成O(1)
(define (adjoin-set x set)
    (cons x set))

;重写union-set，复杂度由O(n^2)变成O(n)
(define (union-set set1 set2)
    (if (null? set1)
        set2
        (union-set (cdr set1) (adjoin-set (car set1) set2))))