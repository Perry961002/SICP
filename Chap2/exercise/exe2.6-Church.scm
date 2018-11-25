;定义过程zero:
;   接受f
;   返回过程:
;       接受x
;       返回x
;((zero f) x) ==> x
(define zero
    (lambda (f)
        (lambda (x)
            x)))

;定义过程add-1:
;   接受过程n
;   返回过程:
;       接受过程f
;       返回过程:
;           接受x
;           返回(f ((n f) x))
;(((add-1 n) f) x) ==> (f ((n f) x))
(define (add-1 n)
    (lambda (f)
        (lambda (x)
            (f ((n f) x)))))

;(add-1 zero)
;(lambda (f) (lambda (x) (f ((zero f) x))))
;(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
;(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
;(lambda (f) (lambda (x) (f x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
;现在可以知道这里的数字表示了运算的次数
;那么 n + m表示在m次运算的基础上进行n次运算
(define (+ m n)
    (lambda (f)
        (lambda (x)
            ((m f) ((n f) x)))))