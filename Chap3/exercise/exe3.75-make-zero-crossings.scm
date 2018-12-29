;做平滑的两个参数是当前信号和前一次信号
;需要感应过零点的信号应该是当前平滑的信号和上一次平滑的信号
(define (make-zero-crossings input-stream last-value last-avpt)
    (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
        (stream-cons (sign-change-detector avpt last-avpt)
                     (make-zero-crossings (stream-cdr input-stream)
                                          (stream-car input-stream)
                                          avpt))))