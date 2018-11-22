;a,b是上下界, term是需要求和的函数过程, next是参数的增长过程
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b) )))

(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
    (sum cube a inc b))

(define (pi-sum a b)
    (define (pi-term x)
        (/ 1.0 (* x (+ x 2))))
    (define (pi-next x)
        (+ x 4))
    (sum pi-term a pi-next b))

;近似积分计算
(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b)
        dx))