(define (require? exp)
    (tagged-list? exp 'require))

(define (require-predicate exp) (cadr exp))

(define (analyze-require exp)
    (let ((pproc (analyze (require-predicate exp))))
        (lambda (env succed fail)
            (pproc env
                   (lambda (pred-value fail2)
                      (if (not pred-value)
                          (fail2)
                          (succed 'ok fail2)))
                   fail))))