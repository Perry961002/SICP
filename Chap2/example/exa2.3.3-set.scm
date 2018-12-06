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
;-------------------------------------------------------------------
;集合作为排序的表

;对于有序集合的element-of-set?操作
(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((= x (car set)) #t)
          ((< x (car set)) #f)
          (else (element-of-set? x (cdr set)))))

;对于有序集合的intersection-set操作
(define (intersection-set set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1
                         (intersection-set (cdr set1) (cdr set2))))
                  ((< x1 x2)
                   (intersection-set (cdr set1) set2))
                  ((< x2 x1)
                   (intersection-set set1 (cdr set2)))))))
;-------------------------------------------------------------------------
;集合作为二叉树(BST)

;用表来表示树，将节点标识为三个元素的表：本节点中的数据项，其左子树和右子树
;用空表作为左子树或者右子树，就表示没有子树连接在那里

;定义BST的抽象
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right))

;判断节点在不在树中
(define (element-of-set? x tree)
    (cond ((null? tree) #f)
          ((= x (entry tree)) #t)
          ((< x (entry tree))
           (element-of-set? x (left-branch tree)))
          ((> x (entry tree))
           (element-of-set? x (right-branch tree)))))

;插入jiedian
(define (adjoin-set x tree)
    (cond ((null? tree) (make-tree x '() '()))
          ((= x (entry tree)) tree)
          ((< x (entry tree))
           (make-tree (entry tree)
                      (adjoin-set x (left-branch tree))
                      (right-branch tree)))
          ((> x (entry tree))
           (make-tree (entry tree)
                      (left-branch tree)
                      (adjoin-set x (right-branch tree))))))