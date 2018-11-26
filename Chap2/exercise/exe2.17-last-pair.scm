;返回只包含给定(非空)表里最后一个元素的表
(define (last-pair items)
    (if (= 1 (length items))
        items
        (last-pair (cdr items))))