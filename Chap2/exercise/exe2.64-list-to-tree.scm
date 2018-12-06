(define (make-tree entry left right)
    (list entry left right))

;将有序表转换成一棵平衡二叉树
(define (list->tree elements)
    (car (partial-tree elements (length elements))))

;将elts的前n个变成树
(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts)
        (let ((left-size (quotient (- n 1) 2))) ;求左子树的节点树
            (let ((left-result (partial-tree elts left-size))) ;对左子树转换成平衡二叉树, left-result的第一个元素就是左子树，其余的就是未转换的元素
                (let ((left-tree (car left-result)) ;取出表中的第一个元素，即左子树
                      (non-left-elts (cdr left-result)) ;取出还未转换的
                      (right-size (- n (+ left-size 1)))) ;确定右子树的大小
                    (let ((this-entry (car non-left-elts)) ;取根节点
                          (right-result (partial-tree (cdr non-left-elts) right-size))) ;转换剩余元素
                        (let ((right-tree (car right-result)) ;右子树
                              (remaining-elts (cdr right-result)))
                            (cons (make-tree this-entry left-tree right-tree)
                                  remaining-elts))))))))

; a)
;原理：以中间元素为根节点，前半部分为左子树，后半部分为右子树，最后合成一棵二叉树
;(list->tree '(1 3 5 7 9 11)) ==> (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

; b)
;按O(n)的量级增长，一个最直观的考虑是因为list->tree过程要对每一个元素进行访问
;写出递归式：T(n) = 2 * T(n/2) + 1
;根据主定理可得T(n) = Θ(n)