;将被积流看作一个延时参数
;integral将在需要生成输出流第一个元素之后的元素时force积分对象的求值
(define (integral delayed-integrand initial-value dt)
    (define int 
        (stream-cons initial-value
                     (let ((integrand (force delayed-integrand)))
                        (add-streams (scale-stream integrand dt)
                                     int))))
    int)

;定义solve时在y的定义里延时求值dy
(define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)

;测试
(stream-ref (solve (lambda (y) y) 1 0.001) 1000)
;2.716923932235896