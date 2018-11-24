(load "Chap1\\example\\exa1.3.3-Process-as-general-method.scm")
;平均阻尼过程, 返回求一个过程f在某一处的平均阻尼过程
(define (average-damp f)
    (lambda (x) (/ (+ x (f x))
                    2)))

(define (sqrt1 x)
    (fixed-point (average-damp (lambda (y) (/ x y)))
                  1.0))

;---------------------------------------------------------------------
;牛顿法
(define dx 0.00001)
;得到g的导数, 返回g的导函数过程
(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
            dx)))

;将g(x) = 0 ==> f(x) = x - g(x) / Dg(x)
(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x)
                ((deriv g) x)))))
;牛顿法找g根据猜测值guess得到的零点
(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (sqrt2 x)
    (newtons-method (lambda (y) (- (* y y) x))
                     1.0))
;--------------------------------------------------------------
;抽象和第一级过程
;从一种函数g出发, 找出在变换transform的不动点、
(define (fixed-point-transform g transform guess)
    (fixed-point (transform g) guess))