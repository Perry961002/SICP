(load "Chap3\\example\\exa3.3.5-make-connector.scm")

;c+以两个连接器为参数，返回与那两个连接器有加法约束的连接器
(define (c+ x y)
    (let ((z (make-connector)))
        (adder x y z)
        z))

;c-以两个连接器为参数，返回与那两个连接器有减法约束的连接器
(define (c- x y)
    (let ((z (make-connector)))
        (adder z y x)
        z))
    
;c*以两个连接器为参数，返回与那两个连接器有乘法约束的连接器
(define (c* x y)
    (let ((z (make-connector)))
        (multiplier x y z)
        z))

;c/以两个连接器为参数，返回与那两个连接器有除法约束的连接器
(define (c/ x y)
    (let ((z (make-connector)))
        (multiplier z y x)
        z))

;cv以一个数为参数，返回这个值的常数连接器
(define (cv x)
    (let ((y (make-connector)))
        (constant x y)
        y))

;测试
(define (cel-fah-con x)
    (c+ (c* (c/ (cv 9) (cv 5))
            x)
        (cv 32)))

(define C (make-connector))
(define F (cel-fah-con C))

;安装监视器
(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)

(forget-value! C 'user)
(set-value! F 212 'user)