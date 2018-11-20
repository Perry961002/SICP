(define (square x) (* x x))

(define (good-enough? guess x) 
    (< (abs (- (square guess) x)) 0.00001))

(define (average x y) 
    (/ (+ x y) 2))

(define (improve guess x) 
    (average guess (/ x guess)))

(define (new-if predicate then-clause else-clause) 
    (cond (predicate then-clause) 
          (else else-clause)))

;因为使用应用序,所以会先对3个参数求值,导致死循环
(define (sqrt-iter guess x) 
    (new-if (good-enough? guess x) 
             guess
             (sqrt-iter (improve guess x)
             x)))

(define (sqrt x) 
    (sqrt-iter 1.0 x))