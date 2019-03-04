; a)
(define (letrec? exp)
    (tagged-list? exp 'letrec))

(define (letrec-bindings exp)
    (cadr exp))

(define (letrec-bindings-vars exp)
    (map car (letrec-bindings exp)))

(define (letrec-bindings-vals exp)
    (map cadr (letrec-bindings exp)))

(define (letrec-body exp)
    (cddr exp))

(define (make-unassigned vars)
    (map (lambda (x) (cons x '*unassigned*))
         vars))

(define (set!-val vars vals)
    (map (lambda (x y) (list 'set! x y))
         vars vals))

;转换为正文里描述的
(define (letrec->let exp)
    (let ((vars (letrec-bindings-vars exp))
          (vals (letrec-bindings-vals exp)))
        (make-let (make-unassigned vars)
                  (append (set!-val vars vals)
                          (letrec-body exp)))))

