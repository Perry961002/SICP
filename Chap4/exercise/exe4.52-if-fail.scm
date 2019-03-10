(define (if-fail? exp)
    (tagged-list? exp 'if-fail))

(define (analyze-if-fail exp)
    (let ((first (analyze (cadr exp)))
          (second (analyze (caddr exp))))
        (lambda (env succed fail)
            (first env
                   (lambda (value fail2)
                    (succed value fail2))
                   (lambda ()
                    (second env succed fail))))))