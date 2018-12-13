;一个简单的过程，对于(+ (f 0) (f 1))从左往右计算时得到0，相反时得到1
(define (make-f)
    (let ((num 1))
        (lambda (x)
            (set! num (* num x))
            num)))
;测试
(define f (make-f))
(define f0 (f 0))
(define f1 (f 1))
(+ f0 f1) ;==> 0

(define ff (make-f))
(define f1 (ff 1))
(define f0 (ff 0))
(+ f0 f1) ;==> 1