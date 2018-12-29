;首先定义过程sign-change-detector
;cur是当前信号，last是上一次的信号
(define (sign-change-detector cur last)
    (cond ((and (< last 0) (> cur 0))
           1)
          ((and (> last 0) (< cur 0))
           -1)
          (else 0)))

;注意在sense-data的第一个信号前面补0，做为第一个信号之前的信号
(define zero-crossings
    (stream-map sign-change-detector sense-data (stream-cons 0 sense-data)))