;框架的一个可能构造函数
(define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))

;选择函数
(define (origin-frame f)
    (car f))

(define (edge1-frame f)
    (cadr f))

(define (edge2-frame f)
    (caddr f))

;框架的另一个构造函数
(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))

;相应的构造函数
(define (origin-frame f)
    (car f))

(define (edge1-frame f)
    (cadr f))

(define (edge2-frame f)
    (cddr f))