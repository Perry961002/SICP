(define (integral delayed-integrand initial-value dt)
    (define int 
        (stream-cons initial-value
                     (let ((integrand (force delayed-integrand)))
                        (add-streams (scale-stream integrand dt)
                                     int))))
    int)

(define (solve-2nd a b dt y0 dy0)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy (add-streams (scale-stream dy a)
                             (scale-stream y b)))
    y)

;测试
;微分方程 y'' - 3 * y' + 2 * y = 0，y0 = 3, dy0 = 5
;特征方程 r^2 - 3 * r + 2 = 0，特征根r1 = 1, r2 = 2
;通解 y = c1 * e^x + c2 * e^(2 * x)
;带入得 y = e^x + 2 * e^(2 * x)
;因为e的近似值为2.718，y的近似值应该是17.493048

(stream-ref (solve-2nd 3 -2 0.001 3 5) 1000)
;17.465548712945107