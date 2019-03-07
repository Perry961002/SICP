;analyze过程
;将之前eval的分类过程提取出来
(define (analyze exp)
    (cond ((self-evaluating? exp)
           (analyze-self-evaluating exp))
          ((quoted? exp)
           (analyze-quoted exp))
          ((variable? exp)
           (analyze-variable exp))
          ((assignment? exp)
           (analyze-assignment exp))
          ((definition? exp)
           (analyze-definition exp))
          ((if? exp)
           (analyze-if exp))
          ((lambda? exp)
           (analyze-lambda exp))
          ((begin? exp)
           (analyze-sequence (begin-action exp)))
          ((cond? exp)
           (analyze (cond->if exp)))
          ((application? exp)
           (analyze-application exp))
          (else
            (error "Unknow expression type -- ANALYZE" exp))))

;处理自求值表达式
(define (analyze-self-evaluating exp)
    (lambda (env) exp))

;提取被引表达式
(define (analyze-quoted exp)
    (let ((qval (text-of-quotation exp)))
        (lambda (env) qval)))

;查看变量需要在执行过程中完成
(define (analyze-variable exp)
    (lambda (env) (lookup-variable-value exp env)))

;设置变量的值
(define (analyze-assignment exp)
    (let ((var (assignment-variable exp))
          (vproc (analyze (assignment-value exp))))
        (lambda (env)
            (set-variable-value! var (vproc env) env)
            'ok)))

(define (analyze-definition exp)
    (let ((var (definition-variable exp))
          (vproc (analyze (definition-value exp))))
        (lambda (env)
            (definition-variable! var (vproc env) env)
            'ok)))

;if表达式
(define (analyze-if exp)
    (let ((pproc (analyze (if-predicate exp)))
          (cproc (analyze (if-consequent exp)))
          (aproc (analyze (if-alternative exp))))
        (lambda (env)
            (if (true? (pproc env))
                (cproc env)
                (aproc env)))))

;分析lambda表达式
(define (analyze-lambda exp)
    (let ((vars (lambda-parameters exp))
          (bproc (analyze-sequence (lambda-body exp))))
        (lambda (env) (make-procedure vars bproc env))))

;分析表达式序列
;对序列中的每一个表达式都将被分析，产生对应的执行过程。最后将这些过程组合起来
(define (analyze-sequence exps)
    ;顺序产生执行过程
    (define (sequentially proc1 proc2)
        (lambda (env) (proc1 env) (proc2 env)))
    ;依次分析每个表达式
    (define (loop first-proc rest-proc)
        (if (null? rest-proc)
            first-proc
            (loop (sequentially first-proc (car rest-proc))
                  (cdr rest-proc))))
    (let ((procs (map analyze exps)))
        (if (null? procs)
            (error "Empty sequence -- ANALYZE"))
        (loop (car procs) (loop procs))))

;分析过程应用
(define (analyze-application exp)
    (let ((fproc (analyze (operator exp)))
          (aprocs (map analyze (operands exp))))
        (lambda (env)
            (execute-application (fproc env)
                                 (map (lambda (aproc) (aproc env))
                                      aprocs)))))

(define (execute-application proc args)
    (cond ((primitive-procedure? proc)
           (apply-primitive-procedure proc args))
          ((compound-procedure? proc)
           ((procedure-body proc)
            (extend-environment (procedure-parameters proc)
                                args
                                (procedure-environment proc))))
          (else
            (error
                "Unknow procedure type -- EXECUTE-APPLICATION"
                proc))))