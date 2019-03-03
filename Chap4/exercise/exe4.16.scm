; a)
(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars)
                   (env-loop (enclosing-environment env)))
                  ((eq? var (car vars))
                   (if (eq? '*unassigned* (car vals))
                       (error "Can't use unassigned variable" var)
                       (car vals)))
                  (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame)
                      (frame-values frame)))))
    (env-loop env))

; b)
;以一个过程体为参数，返回不包括内部定义的等价表达式
(define (scan-out-defines body)
    ;设置特殊符号'*unassigned*
    (define (make-unassigned defines)
        (map (lambda (def) (list (definition-variable def) '*unassigned*))
             defines))
    
    ;对特殊变量赋值
    (define (set-value defines)
        (map (lambda (def) (list 'set! (definition-variable def) (definition-value def)))
             defines))

    ;改成写let形式
    ;exps是所有的表达式，defines是内部定义式，rest-exps是其他表达式
    (define (defines->let exps defines rest-exps)
        (cond ((null? exps)
               (if (null? defines)
                   rest-exps
                   (list (list 'let (make-unassigned defines) (make-begin (append (set-value defines)
                                                                                  rest-exps))))))
              ((definition? (car exps))
               (defines->let (cdr exps) (cons (car exps) defines) rest-exps))
              (else
                (defines->let (cdr exps) defines (cons rest-exps (car exps))))))
    
    (defines->let body '() '()))

; c)
;在 make-procedure 里面添加相当于在定义时就处理好内部定义了
;在 procedure-body 里面添加相当于在应用时再处理内部定义

;具体采用哪种形式的定义，可以根据语言的使用场景来，如果 lambda 定义多而应用少，那么可以在 procedure-body 里面添加，
;反之，可以在 make-procedure 里添加。
