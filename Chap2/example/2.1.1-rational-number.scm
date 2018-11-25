(load "Chap1\\example\\exa1.2.5-GCD.scm")
;返回一个有理数, 约化到最简形式
(define (make-rat n d)
    (let ((g (gcd n d)))
        (cons (/ n g) (/ d g))))
;取得分子
(define (number x)
    (car x))
;取得分母
(define (denom x)
    (cdr x))
;打印一个有理数
(define (print-rat x)
    (newline)
    (display (number x))
    (display "/")
    (display (denom x)))
;两个有理数相加
(define (add-rat x y)
    (make-rat (+ (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))
;减法
(define (sub-rat x y)
    (make-rat (- (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))
;乘法
(define (mul-rat x y)
    (make-rat (* (number x) (number y))
              (* (denom x) (denom y))))
;除法
(define (div-rat x y)
    (make-rat (* (number x) (denom y))
              (* (denom x) (number y))))
;判断相等
(define (equal-rat? x y)
    (= (* (number x) (denom y))
       (* (number y) (denom x))))