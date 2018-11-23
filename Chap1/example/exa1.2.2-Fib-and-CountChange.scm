;对于求Fibonacci数列, 这里给出一个和书上不同的, 使用块结构的程序
(define (fib n) 
    (define (fib-iter a b count)
        (if (= count 0)
            b
            (fib-iter (+ a b) a (- count 1))))
    (fib-iter 1 0 n))

;下面是求换零钱方式的统计的程序
;f(a, n)表示用n种面额的硬币兑换a元的方法数
; f(a, n) = f(a, n-1) + f(a-d, n), d表示第一种硬币的面额
(define (get-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))

(define (cc-recursive amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc-recursive amount 
                                 (- kinds-of-coins 1))
                    (cc-recursive (- amount
                                     (get-denomination kinds-of-coins))
                                   kinds-of-coins)))))

(define (count-change amount)
    (cc-recursive amount 5))