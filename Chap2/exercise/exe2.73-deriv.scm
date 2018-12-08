; a)
;在求导程序中，数字被直接表示为数值类型，而变量被直接表示为符号类型，没有必要画蛇添足

; b)
;补充代码
;加载put和get操作
(load "Chap3\\example\\exa3.3.3-table.scm")
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
    (and (number? exp) (= exp num)))
;重写attach-tag、type-tag和contents操作
(define (attach-tag type-tag x y)
    (list type-tag x y))

(define (type-tag datumn)
    (car datumn))

(define (contents datumn)
    (cdr datumn))

;定义加法求导的程序包
(define (install-sum-package)
    ;内部数据
    (define (addend s) (car s))

    (define (augend s) (cadr s))

    (define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (attach-tag '+ a1 a2))))
    ;外部接口
    (put 'addend '+ addend)

    (put 'augend '+ augend)

    (put 'make-sum '+ make-sum)

    (put 'deriv '+ 
        (lambda (exp var)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var))))
    'Successfully!)

(define (make-sum a1 a2)
    ((get 'make-sum '+) a1 a2))

(define (addend s)
    ((get 'addend '+) (contents s)))

(define (augend s)
    ((get 'augend '+) (contents s)))

;定义乘法求导的程序包
(define (install-mul-package)
    ;内部数据
    (define (multipliter p) (car p))

    (define (multiplicand p) (cadr p))

    (define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (attach-tag '* m1 m2))))
    ;外部接口
    (put 'multipliter '* multipliter)

    (put 'multiplicand '* multiplicand)

    (put 'make-product '* make-product)

    (put 'deriv '* 
        (lambda (exp var)
            (make-sum
                (make-product (multipliter exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multipliter exp) var)
                              (multiplicand exp)))))
    'Successfully!)

(define (make-product m1 m2)
    ((get 'make-product '*) m1 m2))

(define (multiplier p)
    ((get 'multiplier '*) (contents p)))

(define (multiplicand p)
    ((get 'multiplicand '*) (contents p)))

;取操作符
(define (operator exp) (car exp))

;取操作数
(define (operands exp) (cdr exp))

(begin 
    (display "install-sum-package")
    (install-sum-package)
    (newline)
    (display "install-mul-package")
    (install-mul-package)
    (newline))

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
           (if (same-variable? exp var) 1 0))
          (else
            ((get 'deriv (operator exp))
             (operands exp)
             var))))

; c)

;添加乘幂运算包
(define (install-expon-package)
    ;内部数据
    (define (base e)
        (car e))
    (define (exponent e)
        (cadr e))
    (define (make-exponentiation b e)
        (cond ((=number? e 0) 1)
              ((=number? e 1) b)
              (else (attach-tag '** b e))))
    ;外部接口
    (put 'base '** base)

    (put 'exponent '** exponent)

    (put 'make-exponentiation '** make-exponentiation)

    (put 'deriv '**
        (lambda (exp var)
            (make-product (exponent exp)
                          (make-product (make-exponentiation (base exp) (make-sum (exponent exp) -1))
                                        (deriv (base exp) var)))))
    'Successfully!)

(define (make-exponentiation b e)
    ((get 'make-exponentiation '**) b e))

(define (base ex)
    ((get 'base '**) (contents ex)))

(define (exponent ex)
    ((get 'exponent '**) (contents ex)))

(begin
    (display "install-expon-package")
    (newline)
    (install-expon-package))

; d)
;对于题目中提到的情况，只要把put操作的参数的顺序反一下即可