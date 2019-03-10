(define (ramb? exp) (tagged-list? exp 'ramb))

(define (ramb-choices exp) (cdr exp))

;得到l中的随机一项
(define (get-random-of-choices choices)
    (list-ref choices (random (length choices))))

;移除随机项
(define (remove-from x choices)
  (cond ((null? choices) null)
        ((equal? x (car choices)) (cdr choices))
        (else (cons (car choices) (remove-from x (cdr choices))))))

;ramb表达式求值
(define (analyze-ramb exp)
    (let ((cprocs (map analyze (ramb-choices exp))))
        (lambda (env succed fail)
            (define (try-next choices)
                (if (null? choices)
                    (fail)
                    (let ((random-choice (get-random-of-choices choices)))
                        (random-choice env
                                       succed
                                       (lambda ()
                                         (try-next (remove-from random-choice choices)))))))
            (try-next cprocs))))