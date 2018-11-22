;1.32 a)
;使用一般性的累计函数组合起一系列项
;combiner描述将当前项与前面各项组合起来的方式, null-value描述在所有项都用完时的基本值
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a)
                  (accumulate combiner null-value term (next a) next b))))
;--------------------------------------------------------------------------------
;1.32 b)
(define (accumulate-iter combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) 
                  (combiner result
                            (term a)))))
    (iter a null-value))