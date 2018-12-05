;对抽象数据的求导程序
;假定已经有下面的一些过程：
; (variable? e) e是变量吗？
; (same-variable? v1 v2) v1和v2是同一变量吗？

; (sum? e) e是和式吗？
; (addend e) e的被加数
; (augend e) e的加数
; (make-sum a1 a2) 构造起a1与a2的和式

; (product? e) e是乘式吗？
; (multipliter e) e的被乘数
; (multiplicand e) e的乘数
; (make-product m1 m2) 构造起m1和m2的乘式

;再加上判断表达式是否是数值的基本过程number?，构造完整的求导算法
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
          (else
            (error "unknown expression type -- DERIV" exp))))
;----------------------------------------------------------------------------
;代数表达式的表示

;变量就是符号，可以用基本谓词symbol?判断
(define (variable? x) (symbol? x))

;两个变量相同就是表示他们的符号相互eq?
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

;和式和乘式都构造成表
(define (make-sum a1 a2) (list '+ a1 a2))

(define (make-product m1 m2) (list '* m1 m2))

;和式就是第一个元素为符号+的表
(define (sum? x)
    (and (pair? x) (eq? (car x) '+)))

;被加数是表示和式的表里的第二个元素
(define (addend s) (cadr s))

;加数是表示和式的表里的第三个元素
(define (augend s) (caddr s))

;乘式就是第一个元素为符号*的表
(define (product? x)
    (and (pair? x) (eq? (car x) '*)))

;被乘数是表示乘式的表里的第二个元素
(define (multipliter p) (cadr p))

;乘数是表示乘式的表里的第三个元素
(define (multiplicand p) (caddr p))

;化简构造和式和乘式过程
;定义=number?，检查某个表达式是否等于一个给定的数
(define (=number? exp num)
    (and (number? exp) (= exp num)))

;化简和式
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))

;化简乘式
(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))