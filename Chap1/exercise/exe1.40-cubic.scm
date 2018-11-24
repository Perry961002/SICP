(load "Chap1\\example\\exa1.3.4-prodedure-as-the-return-value.scm")
(define (cubic a b c)
    (lambda (x)
        (+ (* x x x)
           (* a (* x x))
           (* b x)
           c)))

;(newtons-method (cubic a b c) 1)