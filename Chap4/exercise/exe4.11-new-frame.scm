;将框架表示为约束的表，每个约束是一个名字-值序对
(define (first-binding frame)
    (car frame))

(define (rest-binding frame)
    (cdr frame))

(define (add-binding-to-frame! var val frame)
    (cons (cons var val frame)))

;因为是序对的表，所以名字和值一定是对应的，添加新框架的话直接添加即可
(define (extend-environment new-frame base-env)
    (cons new-frame base-env))

;在环境中查找变量
(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan frame)
            (cond ((null? frame)
                   (env-loop (enclosing-environment env)))
                  ((eq? val (car (first-binding frame)))
                   (cdr (first-binding frame)))
                  (else (scan (rest-binding frame)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame nev)))
                (scan frame))))
    (env-loop env))

;设置一个新值
(define (set-variable-value! var val env)
    (define (env-loop env)
        (define (scan frame)
            (cond ((null? frame)
                   (env-loop (enclosing-environment env)))
                  ((eq? var (car (first-binding frame)))
                   (set-cdr! (first-binding frame) val))
                  (else (scan (rest-binding)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET" var)
            (let ((frame (first-frame env)))
                (scan frame))))
    (env-loop env))

;定义一个变量
(define (define-variable! var val env)
    (define (scan frame)
        (cond ((null? frame)
               (add-binding-to-frame! var val frame))
              ((eq? var (first-binding frame))
               (set-cdr! (first-binding frame) val))
              (else (sacn (rest-binding frame)))))
    (scan (first-frame env)))