;smooth模块
(define (smooth s)
    (stream-map (lambda (x y) (/ (+ x y) 2))
                s
                (stream-cdr s)))

(define (make-zero-crossings input-stream smooth)
    (let ((smooth-stream (smooth input-stream)))
        (stream-map sign-change-detector 
                    smooth-stream 
                    (stream-cons 0 smooth-stream))))