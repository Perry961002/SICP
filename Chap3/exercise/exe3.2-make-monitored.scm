;创建一个程序调用监视器
;以一个过程 f 为参数，返回一个过程，假设为mf
;如果 mf 的输入是字符 how-many-calls?，就返回内部计数器的值
;如果输入是字符 reset-count，则将计数器的值重新置为0
;对于其他任何输入，将返回过程 f 应用于这个输入的值
(define (make-monitored f)
    (let ((calls 0))
        (lambda (x)
                (cond ((eq? x 'how-many-calls?)
                       calls)
                      ((eq? x 'reset-count)
                       (set! calls 0))
                      (else (begin (display (f x))
                                   (set! calls (+ calls 1))))))))