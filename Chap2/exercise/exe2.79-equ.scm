;安装到常规数包
(define (install-scheme-number-package)
    (put 'equ? '(scheme-number scheme-number) =)
    'done)

;安装到有理数包
(define (install-rational-package)
    (define (equ? x y)
        (= (* (number x) (denom y))
           (* (number y) (denom x))))
    (put 'equ? '(rational rational) equ?)
    'done)

;安装到复数包
(define (install-complex-package)
    (define (equ? z1 z2)
        (and (= (real-part z1) (real-part z2))
             (= (imag-part z1) (imag-part z2))))
    (put 'equ? '(complex complex) equ?)
    'done)

(define (equ? x y)
    (apply-generic 'equ? x y))