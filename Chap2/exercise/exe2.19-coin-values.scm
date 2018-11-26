;判断coin-values是否为空, 空就返回true
(define (no-more? coin-values)
    (null? coin-values))

;得到表的第一个元素， 因为已经判断是否为空了, 所以这里就不写了
(define (first-denomination coin-values)
    (car coin-values))

;得到除去第一个元素之后的其他元素组成的表
(define (except-first-denomination coin-values)
    (cdr coin-values))

;重写cc函数
;可以知道答案和coin-values中元素的顺序无关
;因为f(a, n)表示用n种面额的硬币兑换a元的方法数
; f(a, n) = f(a, n-1) + f(a-d, n), d表示第一种硬币的面额
(define (cc amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (no-more? coin-values)) 0)
          (else
            (+ (cc amount
                   (except-first-denomination coin-values))
               (cc (- amount
                      (first-denomination coin-values))
                   coin-values)))))