;方便使用fixed-point过程
(load "Chap1\\example\\exa1.3.3-Process-as-general-method.scm")

(define golden-ratio
    (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.5))