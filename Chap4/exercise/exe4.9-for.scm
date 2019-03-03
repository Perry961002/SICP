;这里效仿python的range函数给出scheme里的for过程
;我的定义是(for (var start end step)
;               <body>)
;我的想法是如果var在start到end之间就执行过程体，然后加上步长step，重复上面的过程，直到跳出范围

(define (for? exp)
    (taggesd-list exp 'for))

(define (for-var exp)
    (caadr exp))

(define (for-start exp)
    (cadadr exp))

(define (for-end exp)
    (caddadr exp))

(define (for-step exp)
    (cadddadr exp))

(define (for-body exp)
    (cddr exp))

(define (range start end step proc)
    (cond ((> step 0)
           (cond ((< start end)
                  (proc start)
                  (range (+ start step) end step proc))))
          ((< step 0)
           (cond ((> start end)
                  (proc start)
                  (range (+ start step) end step proc))))
          (else
            (erro "step can not is 0"))))

(define (for->combination exp)
    (range (for-start exp)
           (for-end exp)
           (for-step exp)
           (make-lambda (list (for-var exp))
                        (for-body exp))))