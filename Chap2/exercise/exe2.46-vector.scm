;实现向量的数据抽象

;构造函数
(define (make-vect x y)
    (cons x y))

;选择函数
(define (xcor-vect v)
    (car v))

(define (ycor-vect v)
    (cdr v))

;向量加法过程
(define (add-vect u v)
    (make-vect (+ (xcor-vect u) (xcor-vect v))
               (+ (ycor-vect u) (ycor-vect v))))

;向量的减法过程
(define (sub-vect u v)
    (make-vect (- (xcor-vect u) (xcor-vect v))
               (- (ycor-vect u) (ycor-vect v))))

;向量的伸缩
(define (scale-vect v s)
    (make-vect (* (xcor-vect v) s)
               (* (ycor-vect v) s)))