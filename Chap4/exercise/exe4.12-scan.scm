;观察题目中的三个过程中的scan的定义
;明显的我们发现，三个的不同在于vars为空时的动作以及匹配到var时的动作
;现在我们定义更一般的scan过程
(define (scan vars vals null-action found-action)
    (cond ((null? vars)
           (null-action))
          ((eq? var (car vars))
           (found-action vals))
          (else (scan (cdr vars) (cdr vals)))))

;用公共的scan重新定义那三个过程
(define (lookup-variable-value var env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable " var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame)
                      (lambda () (env-loop (enclosing-environment env)))
                      (lambda (vals) (car vals))))))
    (env-loop env))

(define (set-variable-value! var val env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame) (frame-values frame)
                      (lambda () (env-loop (enclosing-environment env)))
                      (lambda (vals) (set-car! vals val))))))
    (env-loop env))

(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (scan (frame-variables frame) (frame-values frame)
              (lambda () (add-binding-to-frame! var val frame))
              (lambda (vals) (set-car! vals val)))))