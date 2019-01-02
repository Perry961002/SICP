; eval定义
; 输入参数时一个表达式和一个环境
(define (eval exp env)
    (cond ((self-evaluating? exp) exp) ;子求值
          ((variable? exp) (look-variable-value exp env)) ;在环境中查找变量
          ((quoted? exp) (text-of-quotation exp)) ;加引号的表达式
          ((assignment? exp) (eval-assignment exp env)) ;赋值
          ((definition? exp) (eval-definition exp env)) ;定义
          ((if? exp) (eval-if exp env)) ;if表达式
          ((lambda? exp) ;lambda过程
           (make-procedure (lambda-parameters exp)
                           (lambda-body exp)
                           env))
          ((begin? exp) ;begin表达式
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond-if exp) env)) ;cond表达式
          ((application? exp) ;组合式
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else 
            (error "Unknown expression type -- EVAL" exp))))

;apply定义
;两个参数。一个是过程，一个是该过程应该去应用的实际参数的表
;分成两类，一类是基本应用过程，另一类是应用复合过程
(define (apply procedure arguments)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure procedure arguments))
          ((compound-procedure? procedure)
           (eval-sequence
                (procedure-body procedure)
                (extend-environment
                    (procedure-parameters procedure)
                    arguments
                    (procedure-environment procedure))))
          (else
            (error "Unknown procedure type -- APPLY" procedure))))

;过程参数
;list-of-values以组合式的运算对象为参数，求值各个运算对象，返回这些值的表
(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

;条件，先求值谓词为真，如果结果为真就求值推论部分
(define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))

;序列
;以一个表达式序列和一个环境为参数，按照序列里表达式出现的顺序求值,将有关值安置到指定环境里
(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps) env))))

;赋值和定义
;将变量和得到的值传给set-variable-value!，将有关的值安置到指定环境
(define (eval-assignment exp env)
    (set-variable-value! (assignment-variable exp)
                         (eval (assignment-value exp) env)
                         env)
    'ok)

(define (eval-definition exp env)
    (define-variable! (define-variable exp)
                      (eval (definition-value exp) env)
                      env)
    'ok)