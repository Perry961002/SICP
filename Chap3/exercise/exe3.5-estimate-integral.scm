;蒙特卡罗过程
(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
              ((experiment)
               (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

;产生在一定区域内的随机数
(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

;判断点(x, y)是否在以点(px, py)为圆心, r为半径的圆内
(define (in-circle? px py r x y)
    (define (square m) (* m m))

    (<= (+ (square (- x px)) (square (- y py)))
        (square r)))

;蒙特卡罗积分
(define (estimate-integral p x1 x2 y1 y2 trials)
    (define (cesaro-test)
        (p (random-in-range x1 x2) (random-in-range y1 y2)))
    (* (* (- x2 x1) (- y2 y1))
       (monte-carlo trials cesaro-test)))

(define (estimate-pi x1 x2 y1 y2 trials)
    (estimate-integral (lambda (x y)
                               (in-circle? (/ (+ x1 x2) 2) (/ (+ y1 y2) 2) 1.0 x y))
                       x1 x2 y1 y2 trials))

;测试：
;(estimate-pi -10.0 10.0 -10.0 10.0 100000000) ==> 3.140568