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
                              (multiplicandexp))))
          (else
            (error "unknown expression type -- DERIV" exp))))