(load "Chap2\\exercise\\exe2.63-tree-to-list.scm")
(load "Chap2\\exercise\\exe2.64-list-to-tree.scm")

;有序集合的union-set操作
(define (union-sort-set set1 set2)
    (cond ((null? set1) set2)
          ((null? set2) set1)
          (else
            (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1
                             (union-sort-set (cdr set1) (cdr set2))))
                      ((< x1 x2)
                       (cons x1
                             (union-sort-set (cdr set1) set2)))
                      (else (cons x2
                                  (union-sort-set set1 (cdr set2)))))))))

;对于有序集合的intersection-set操作
(define (intersection-sort-set set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1
                         (intersection-sort-set (cdr set1) (cdr set2))))
                  ((< x1 x2)
                   (intersection-sort-set (cdr set1) set2))
                  ((< x2 x1)
                   (intersection-sort-set set1 (cdr set2)))))))

;对采用平衡二叉树的union-set操作
(define (union-set tree1 tree2)
    (let ((set1 (tree->list-2 tree1)) (set2 (tree->list-2 tree2)))
        (list->tree (union-sort-set set1 set2))))

;对采用平衡二叉树的union-set操作
(define (intersection-set tree1 tree2)
    (let ((set1 (tree->list-2 tree1)) (set2 (tree->list-2 tree2)))
        (list->tree (intersection-sort-set set1 set2))))