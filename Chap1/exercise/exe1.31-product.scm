;给定在给定范围中各点的某个函数值的乘积
(define (product term a next b)
    (if (> a b)
        1
        (* (term a)
           (product term (next a) next b))))

;定义factorial
(define (factorial n)
    (define (f x)
        (if (= (remainder x 2) 1)
            (/ (+ x 1) (+ x 2))
            (/ (+ x 2) (+ x 1))))
    (define (inc k) (+ k 1))
    (product f 1 inc n))
;--------------------------------------------------------------------------

;使用迭代过程
(define (product-iter term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* (term a) result))))
    (iter a 1))