;安装环境
(define (setup-environment)
    (let ((initial-env
            (extend-environment (primitive-procedure-names)
                                (primitive-procedure-objects)
                                the-empty-environment)))
        (define-variable! 'true #t initial-env)
        (define-variable! 'false #f initial-env)
        initial-env))

(define the-global-environment (setup-environment))

(define (primitive-procedure? proc)
    (tagged-list? proc 'primitive))


(define (primitive-implementation proc) (cadr proc))

(define primitive-procedures 
    (list (list 'car car)
          (list 'cdr cdr)
          (list 'cons cons)
          (list 'null? null?)))

(define (primitive-procedure-names)
    (map car primitive-procedures))

(define (primitive-procedure-objects)
    (map (lambda (proc) (list 'primitive (cadr proc)))
         primitive-procedures))

(define apply-in-underlying-scheme apply)

(define (apply-primitive-procedure proc args)
    (apply-in-underlying-scheme 
        (primitive-implementation proc) args))