(define (permanent-set? exp) 
    (tagged-list? exp 'permanent-set!))

;既然遇到失败了不用撤销，那么就不用记录原来的值
(define (analyze-permanent-set exp)
    (let ((var (assignment-variable exp))
          (vproc (analyze (assignment-value exp))))
        (lambda (env succed fail)
            (vproc env
                   (lambda (val fail2)
                        (set-variable-value! var val env)
                        (succed 'ok fail2))
                   fail))))