(load "Chap2\\example\\exa2.3.4-Huffman.scm")
(load "Chap2\\exercise\\exe2.67-decode.scm")

;以一个符号-频度对偶表为参数生成Huffman编码树
(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

;反复归并集合中具有最小权重的元素，直到集合里只剩下一个元素为止
(define (successive-merge pairs)
    (cond ((null? pairs) '())
          ((= (length pairs) 1) (car pairs))
          (else
            (let ((left (car pairs))
                  (right (cadr pairs)))
                (let ((symbol (make-code-tree left right)))
                    (successive-merge (adjoin-set symbol
                                                  (cddr pairs))))))))

;测试用例
; (define sample-pairs '((A 4) (B 2) (C 1) (D 1)))
; (define tree (generate-huffman-tree sample-pairs))
; (decode sample-message tree) ==> (A D A B B C A)