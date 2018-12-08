(load "Chap3\\example\\exa3.3.3-table.scm") ;put和get过程
(load "Chap1\\example\\exa1.2.5-GCD.scm")
(load "Chap2\\example\\exa2.4.3-data-guide.scm")
;过程attach-tag，以一个标志和实际内容为参数，生成出一个带标志的数据对象
(define (attach-tag type-tag contents)
    (cons type-tag contents))

;提取出类型标志
(define (type-tag datum)
    (if (pair? datum)
        (car datum)
        (error "Bad tagged datum -- TYPE-TAG" datum)))

;提取实际内容
(define (contents datum)
    (if (pair? datum)
        (cdr datum)
        (error "Bad tagged datum -- CONTENTS" datum)))

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error
                    "No method for these types -- APPLY-GENERIC"
                    (list op type-tags))))))

;通用算数过程
(define (add x y) (apply-generic 'add x y))

(define (sub x y) (apply-generic 'sub x y))

(define (mul x y) (apply-generic 'mul x y))

(define (div x y) (apply-generic 'div x y))

;处理常规数的包
(define (install-scheme-number-package)
    (define (tag x) 
        (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number)
        (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number)
        (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number)
        (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number)
        (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number
        (lambda (x) (tag x)))
    'done)
;创建带标志的常规数
(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))
;--------------------------------------------------------
;执行有理数算数系统的包
(define (install-rational-package)
    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))
    ;取得分子
    (define (number x)
        (car x))
    ;取得分母
    (define (denom x)
        (cdr x))
    
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
    
    (define (tag x) (attach-tag 'rational x))

    (put 'add '(rational rational)
        (lambda (x y) (tag (add-rat x y))))
    
    (put 'sub '(rational rational)
        (lambda (x y) (tag (sub-rat x y))))

    (put 'mul '(rational rational)
        (lambda (x y) (tag (mul-rat x y))))

    (put 'div '(rational rational)
        (lambda (x y) (tag (div-rat x y))))
    
    (put 'make 'rational
        (lambda (n d) (tag (make-rat n d))))
    'done)
;创建带标志的有理数
(define (make-rational n d)
    ((get 'make 'rational) n d))
;-----------------------------------------------------
;处理复数的程序包
(define (install-complex-package)
    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))

    (define (add-complex z1 z2)
        (make-from-real-imag (+ (real-part z1) (real-part z2))
                             (+ (imag-part z1) (imag-part z2))))

    (define (sub-complex z1 z2)
        (make-from-real-imag (- (real-part z1) (real-part z2))
                             (- (imag-part z1) (imag-part z2))))

    (define (mul-complex z1 z2)
        (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                           (+ (angle z1) (angle z2))))

    (define (div-complex z1 z2)
        (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                           (- (angle z1) (angle z2))))
    
    (define (tag z) (attach-tag 'complex z))

    (put 'add '(complex complex)
        (lambda (z1 z2) (tag (add-complex z1 z2))))

    (put 'sub '(complex complex)
        (lambda (z1 z2) (tag (sub-complex z1 z2))))

    (put 'mul '(complex complex)
        (lambda (z1 z2) (tag (mul-complex z1 z2))))

    (put 'div '(complex complex)
        (lambda (z1 z2) (tag (div-complex z1 z2))))

    (put 'make-from-real-imag 'complex
        (lambda (x y) (tag (make-from-real-imag x y))))

    (put 'make-from-mag-ang 'complex
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))

(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))