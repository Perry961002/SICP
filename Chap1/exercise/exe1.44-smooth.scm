(load "Chap1\\exercise\\exe1.43-repeated.scm")
(define dx 0.00001)
;定义求f的平滑函数
(define (smooth f)
    (lambda (x)
        (/ (+ (f (- x dx))
              (f x)
              (f (+ x dx)))
            3.0)))

;定义求f的n次平滑的函数的过程
(define (smooth-n f n)
    (lambda (x)
        (((repeated smooth n) f) x)))