;类似integers-starting-from过程的使用force的integral过程
(define (integral delayed-integrand initial-value dt)
    (stream-cons initial-value
        (let ((integrand (force delayed-integrand)))
            (if (stream-empty? integrand)
                '()
                (integral (stream-cdr integrand)
                          (+ (* dt (stream-car integrand))
                             initial-value)
                          dt)))))

;测试
;定义solve时在y的定义里延时求值dy
(define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)

(stream-ref (solve (lambda (y) y) 1 0.001) 1000)
;2.716923932235896