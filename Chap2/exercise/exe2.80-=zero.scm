;安装到常规数包
(define (install-scheme-number-package)
    (put '=zero? '(scheme-number scheme-number) (lambda (x) (= x 0)))
    'done)

;安装到有理数包
(define (install-rational-package)
    (put '=zero? '(rational rational) (lambda (x) (= (numer x) 0)))
    'done)

;安装到复数包
(define (install-complex-package)
    (put '=zero '(complex complex) (lambda (z) 
                                        (and (= (real-part z) 0)
                                             (= (imag-part z) 0))))
    'done)

(define (=zero? x)
    (apply-generic '=zero? x))