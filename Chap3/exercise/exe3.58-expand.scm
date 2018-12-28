(define (expand num den radix)
    (stream-cons
        (quotient (* num radix) den)
        (expand (remainder (* num radix) den) den radix)))
;expand 生成的流的car是 (* num radix) 除以 den 的商
;cdr是将 (* num radix) 除以 den 的余数作为 num 参数，递归地调用 expand 产生的许诺
;产生的结果是(num * radix) / den的完全展开

;(display-top10 (expand 1 7 10))
;1  4  2  8  5  7  1  4  2  

;(display-top10 (expand 3 8 10))
;3  7  5  0  0  0  0  0  0  