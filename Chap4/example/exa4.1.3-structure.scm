;谓词检测
(define (true? x)
    (not (eq? x #f)))

(define (false? x)
    (eq? x #f))

;复合过程的判断、构造和选择函数
(define (make-procedure parameters body env)
    (list 'procedure parameters body env))

(define (compound-procedure? p)
    (tagged-list? p 'procedure))

;形参
(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-environment p) (cadddr p))

;一个环境就是一个框架的序列，每个框架都是一个约束的表格

;我们将环境表示为一个框架的表，环境的外围环境就是这个表的cdr
(define (enclosing-environment env) (cdr env))

;第一个框架
(define (first-frame env) (car env))

(define the-empty-environment '())

;每个框架都是一对表形成的序对：一个是这个框架中所有变量的表，另一个是它们约束值的表
(define (make-frame variables values)
    (cons variables values))

(define (frame-variables frame) (car frame))

(define (frame-values frame) (cdr frame))

;给框架中添加新的约束
(define (add-binding-to-frame! var val frame)
    (set-car! frame (cons var (car frame)))
    (set-cad! frame (cons val (cdr frame))))

;用一个新的框架去扩充一个环境
(define (extend-environment vars vals base-env)
    (if (= (length vars) (length vals))
        (cons (make-frame vars vals) base-env)
        (if (< (length vars) (length vals))
            (error "Too many arguments supplied" vars vals)
            (error "Too few arguments supplied" vars vals))))

;在环境中查找一个变量
(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars)
                   (env-loop (enclosing-environment env)))
                  ((eq? var (car vars))
                   (car vars))
                  (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame)
                      (frame-values frame)))))
    (env-loop env))

;在环境中给某个变量设置新值
(define (set-variable-value! var val env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars)
                   (env-loop (enclosing-environment env)))
                  ((eq? var (car vars))
                   (set-car! vars))
                  (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame)
                      (frame-values frame)))))
    (env-loop env))

;定义一个变量
(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (define (scan vars vals)
            (cond ((null? vars)
                   (add-binding-to-frame! var val frame))
                  ((eq? var (car vars))
                   (set-car! vals val))
                  (else (scan (cdr vars) (cdr vals)))))
        (scan (frame-variables frame)
              (frame-values frame))))