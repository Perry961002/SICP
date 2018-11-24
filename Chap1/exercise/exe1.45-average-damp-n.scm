(load "Chap1\\exercise\\exe1.43-repeated.scm")
(load "Chap1\\example\\exa1.3.3-Process-as-general-method.scm")
(load "Chap1\\example\\exa1.2.4-expt.scm")
(define (average-damp f)
    (lambda (x) (/ (+ x (f x))
                    2)))
;n次平均阻尼
(define (average-damp-n f n)
    ((repeated average-damp n) f))

;使用damp-times次的平均阻尼计算n次方根
(define (n-root-damp-times n damp-times)
    (lambda (x)
        (fixed-point (average-damp-n (lambda (y) (/ x (fast-expt y (- n 1)))) damp-times)
                     1.0)))

;计算以2为底的n的对数
(define (lg n)
    (cond ((> (/ n 2) 1)
            (+ 1 (lg (/ n 2))))
          ((< (/ n 2) 1)
            0)
          (else
            1)))
;计算x的n次方根
(define (n-root x n)
    ((n-root-damp-times n (lg n)) x))