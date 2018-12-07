(load "Chap2\\example\\exa2.3.4-Huffman.scm")

;样例编码树
(define sample-tree
    (make-code-tree (make-leaf 'A 4)
                    (make-code-tree
                        (make-leaf 'B 2)
                        (make-code-tree (make-leaf 'D 1)
                                        (make-leaf 'C 1)))))

;样例消息
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree) ;==> (A D A B B C A)