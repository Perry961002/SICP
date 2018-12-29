(define (solve-2nd-generic f dt y0 dy0)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy (stream-map (lambda (dy y) (f dy y))
                            dy
                            y))
    y)