;产生子集表的过程
(define (subsets s)
    (if (null? s)
        (list '())
        (let ((rest (subsets (cdr s)))) ;除去首元素之后的子集表
            (append rest (map (lambda (x) ;对于rest中的每个元素可以选择把(car s)加入其中, 或者不加
                                    (cons (car s) x))
                              rest)))))