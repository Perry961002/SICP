;欧几里得算法
(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 137)

;随机数流
(define random-numbers
    (stream-cons random-init
                 (stream-map rand-update random-numbers)))

;构造出试验的输出流
(define cesaro-stream
    (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                          random-numbers))

(define (map-successive-pairs f s)
    (stream-cons
        (f (stream-car s) (stream-car (stream-cdr s)))
        (map-successive-pairs f (stream-cdr (stream-cdr s)))))

;蒙特卡罗过程
;参数为实验结果流，成功次数，失败次数
(define (monte-carlo experiment-stream passed failed)
    (define (next passed failed)
        (stream-cons
            (/ passed (+ passed failed))
            (monte-carlo
                (stream-cdr experiment-stream) passed failed)))
    (if (stream-car experiment-stream)
        (next (+ passed 1) failed)
        (next passed (+ failed 1))))

;pi的模拟流
(define pi 
    (stream-map (lambda (p) (sqrt (/ 6 p)))
                (monte-carlo cesaro-stream 0 0)))
        
;-----------------------------------------------------------------
;时间的函数式程序设计观点
(define (stream-withdraw balance amount-stream)
    (stream-cons
        balance
        (stream-withdraw (- balance (stream-car amount-stream))
                         (stream-cdr amount-stream))))