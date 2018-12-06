;集合作为未排序的表

;判断元素是不是在集合中
(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((equal? x (car set)) #t)
          (else (element-of-set? x (cdr set)))))

;把元素加入集合
(define (adjoin-set x set)
    (if (element-of-set? x set)
        set
        (cons x set)))

;求两个集合的交集
(define (intersection-set set1 set2)
    (cond ((or (null? set1) (null? set2)) '())
          ((element-of-set? (car set1) set2)
           (cons (car set1)
                 (intersection-set (cdr set1) set2)))
          (else (intersection-set (cdr set1) set2))))