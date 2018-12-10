(load "Chap2\\exercise\\exe2.79-equ.scm")
;安装project过程
(define (install-rational-package)
    ;...
    (put 'project 'rational 
        (lambda (x) (make-scheme-number (round (/ (numer x) (denom x))))))
    'done)

(define (install-real-package)
    ;...
    (put 'project 'real 
        (lambda (x)  
        (let ((rat (rationalize  
                    (inexact->exact x) 1/100))) 
            (make-rational 
            (numerator rat) 
            (denominator rat)))))
    'done)

(define (install-complex-package)
    ;...
    (put 'project 'complex 
        (lambda (x) (make-real (real-part x))))
    'done)

(define (drop x)
    (let ((proc (get 'project (type-tag x))))
        (if proc
            (let ((lower (proc (tonents x))))
                (if (equ? (raise lower) x)
                    (drop lower)
                    x))
            x)))

;重写apply-generic过程
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (drop (apply proc (map contents args)))
                (if (= (length args) 2)
                    (let ((type1 (type-tag (car args)))
                          (type2 (type-tag (cadr args)))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (cond ((raise-up a1 a2)
                               (drop (apply-generic op (raise-up a1 a2) a2)))
                              ((raise-up a2 a1)
                               (drop (apply-generic op a1 (raise-up a2 a1))))
                              (else
                                (error "No method for these types"
                                        (list op type-tags)))))
                    (else
                        (error "No method for these types"
                                (list op type-tags))))))))