(load "Chap2\\exercise\\exe2.69-generate-huffman-tree.scm")
(load "Chap2\\exercise\\exe2.68-encode.scm")

;得到字母表对应的Huffman树
(define tree
    (generate-huffman-tree '((Get 2) (a 2) (job 2) (Sha 3) (na 16) (Wah 1) (yip 9) (boom 1))))

(map (lambda (x) 
        (begin
            (display x)
            (display (encode x tree))
            (newline)))
     '((Get a job) (Sha na na na na na na na na)
       (Get a job) (Sha na na na na na na na na)
       (Wah yip yip yip yip yip yip yip yip yip) (Sha boom)))

;结果
;(Wah yip yip yip yip yip yip yip yip yip)(1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
;(Sha boom)(1 1 1 0 1 1 0 1 0)
;(Get a job)(1 1 0 0 1 1 1 1 1 1 1 1 1 0)
;(Sha na na na na na na na na)(1 1 1 0 0 0 0 0 0 0 0 0)
;(Get a job)(1 1 0 0 1 1 1 1 1 1 1 1 1 0)
;(Sha na na na na na na na na)(1 1 1 0 0 0 0 0 0 0 0 0)