(load "Chap1\\example\\exa1.2.5-GCD.scm")
(define random-init 1)
(define (rand-update x)
  (remainder (+ (* 5 x) 3) 4294967296))

;随机数
(define rand
    (let ((x random-init))
        (lambda ()
            (set! x (rand-update x))
            x)))

;蒙特卡罗模拟，以某个试验的次数，以及这个试验本身作为参数。有关实验用一个无参过程表示，返回的是每次运行的结果为真或假
;返回所做的这些次试验中得到真的比例
(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
              ((experiment)
               (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

;判断两个整数之间有没有公共因子
(define (cesaro-test)
    (= (gcd (rand) (rand)) 1))

;得到pi的近似值
(define (estimate-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test))))