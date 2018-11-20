(define (subic x) (* x x x))

(define (average x y) (/ (+ x y) 3.0))

(define (good-enough? guess x) 
    (< (abs (- (subic guess) x)) 
        0.0001))

(define (improve guess x) 
    (average (/ x (* guess guess)) 
             (* 2 guess)))

(define (iter guess x) 
    (if (good-enough? guess x) 
        guess
        (iter (improve guess x) 
               x)))

(define (substriplicate x) 
    (iter 1.0 x))