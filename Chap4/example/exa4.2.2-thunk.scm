;创建槽，包装一个包含表达式和对应环境的表
(define (delay-it exp env)
    (list 'thunk exp env))

(define (thunk? obj)
    (tagged-list? obj 'thunk))

(define (thunk-exp thunk)
    (cadr thunk))

(define (thunk-env thunk)
    (caddr thunk))

;带记忆化的槽
;是否被求值了
(define (evaluated-thunk? obj)
    (tagged-list? obj 'evaluated-thunk))

(define (thunk-value evaluated-thunk)
    (cadr evaluated-thunk))

(define (force-it obj)
    (cond ((thunk? obj)
           (let ((result (actual-value
                            (thunk-exp obj)
                            (thunk-env obj))))
                (set-car! obj 'evaluated-thunk)
                (set-car! (cdr obj) result)
                (set-cdr! (cdr obj) '())
                result))
          ((evaluated-thunk? obj)
           (thunk-value obj))
          (else obj)))

;取表达式的实际值
(define (actual-value exp env)
    (force-it (eval exp env)))

(define (list-of-arg-values exps env)
    (if (no-operands? exps)
        '()
        (cons (actual-value (first-operand exps) env)
              (list-of-arg-values (rest-operands exps)
                                  env))))

(define (list-of-delayed-args exps env)
    (if (no-operands? exps)
        '()
        (cons (delay-it (first-operand exps) env)
                        (list-of-delayed-args (rest-operands exps)
                                              env))))

(define (eval-if exp env)
    (if (true? (actual-value (if-predicatenexp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))

(define (apply procedure arguments env)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure
            procedure
            (list-of-arg-values arguments env)))
          ((compound-procedure? procedure)
           (eval-sequence
            (procedure-body procedure)
            (extend-environment
                (procedure-parameters procedure)
                (list-of-delayed-args arguments env)
                (procedure-environment procedure))))
          (else
            (error
                "Unknown procedure type -- APPLY" procedure))))