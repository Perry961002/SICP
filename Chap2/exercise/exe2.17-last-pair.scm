;返回只包含给定非空表里最后一个元素的表
(define (last-pair items)
    (if (= 1 (length items))
        items
        (last-pair (cdr items))))