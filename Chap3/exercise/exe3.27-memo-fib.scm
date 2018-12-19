;定义make-table
(define (make-table)
    (let ((local-table (list '*table)))
        (define (assoc key records)
            (cond ((null? records) #f)
                  ((equal? key (caar records)) (car records))
                  (else (assoc key (cdr records)))))
        (define (lookup key)
            (let ((record (assoc key (cdr local-table))))
                (if record
                    (cdr record)
                    #f)))
        (define (insert! key value)
            (let ((record (assoc key (cdr local-table))))
                (if record
                    (set-cdr! record value)
                    (set-cdr! local-table
                              (cons (cons key value) (cdr local-table)))))
            'ok)
        (define (dispatch m)
            (cond ((eq? m 'lookup) lookup)
                  ((eq? m 'insert!) insert!)
                  (else (error "Unknown operation -- TABLE" m))))
        dispatch))

(define (lookup key table) ((table 'lookup) key))
(define (insert! key value table) ((table 'insert!) key value))

;不带记录的版本
(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2))))))

;定义记录器，它以一个过程f为参数
(define (memoize f)
    (let ((table (make-table)))
        (lambda (x)
            (let ((previously-computed-result (lookup x table)))
                (or previously-computed-result
                    (let ((result (f x)))
                        (insert! x result table)
                        result))))))
            
;带记录的版本
(define memo-fib
    (memoize (lambda (n)
                (cond ((= n 0) 0)
                      ((= n 1) 1)
                      (else (+ (memo-fib (- n 1))
                               (memo-fib (- n 2))))))))

;如果简单的将memo-fib定义为 (memoize fib)，虽然可以算出结果，但是fib是直接算出结果，并没有使用表格记忆法，复杂度高