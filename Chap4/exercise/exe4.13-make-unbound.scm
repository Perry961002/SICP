;因为前面的相关定义我们知道define创建新的约束时总是添加到第一个框架
;所以我们只需要删除第一个框架里的约束
(define (make-unbound! var env)
    (let ((frame (first-frame env)))
        (define (scan vars vals)
            (cond ((null? var)
                   (error "Unbound variable" var))
                  ((eq? var (car vars))
                   (set! vars (cdr vars))
                   (set! vals (cdr vals))
                   'OK)
                  (else (scan (cdr vars) (cdr vals)))))
        (scan (frame-variables frame)
              (frame-values frame))))