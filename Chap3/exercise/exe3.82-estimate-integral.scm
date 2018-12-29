;产生在一定区域内的随机数
(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

;判断点p是否在以点(0, 0)为圆心, 1为半径的圆内
(define (in-circle? p)
    (define (square m) (* m m))
    (<= (+ (square (- (car p) 1)) (square (- (cdr p) 1)))
        1.0))

;生成在矩形区域内的随机点的坐标流
(define (random-pairs x1 x2 y1 y2)
    (stream-cons (cons (random-in-range x1 x2)
                       (random-in-range y1 y2))
                 (random-pairs x1 x2 y1 y2)))

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

;蒙特卡罗积分流
(define (estimate-integral p x1 x2 y1 y2)
    (let ((area (* (- x2 x1) (- y2 y1)))
          (pairs (random-pairs x1 x2 y1 y2)))
        (scale-stream (monte-carlo (stream-map p pairs) 0 0) area)))

;pi的模拟值流
(define pi 
    (estimate-integral (lambda (p) (in-circle? p))
                       0
                       2
                       0
                       2))

(stream-ref pi 100)
;3.2475247524752477