(load "Chap2\\example\\exa2.3.2-Symbolic-guidance.scm")

;指数式就是第一个元素是**的biao
(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**)))

;底数就是指数式的第二个元素
(define (base e)
    (cadr e))

;指数是指数式的第三个元素
(define (exponent e)
    (caddr e))

;构造指数式
(define (make-exponentiation b e)
    (cond ((=number? e 0) 1)
          ((=number? e 1) b)
          (else (list '** b e))))

;为deriv增加一个新的句子
(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
           (if (same-variable? exp var) 1 0))
          ((sum? exp)
           (make-sum (deriv (addend exp) var)
                     (deriv (augend exp) var)))
          ((product? exp)
           (make-sum
                (make-product (multipliter exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multipliter exp) var)
                              (multiplicand exp))))
          ((exponentiation? exp)
           (make-product (exponent exp)
                         (make-product (make-exponentiation (base exp) (make-sum (exponent exp) -1))
                                       (deriv (base exp) var))))
          (else
            (error "unknown expression type -- DERIV" exp))))