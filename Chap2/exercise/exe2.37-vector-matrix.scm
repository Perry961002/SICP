(load "Chap2\\exercise\\exe2.36-accumulate-n.scm")

(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))

(define v (list 1 1 1 1))

(define n (list (list 1 0 1) (list 0 1 0) (list 0 1 1) (list 1 1 0)))

;点积
(define (dot-product v w)
    (accumulate + 0 (map * v w)))

;matrix * vector
(define (matrix-*-vector m v)
    (map (lambda (x) 
                 (if (null? x)
                     '()
                     (dot-product x v)))
         m))

;矩阵转置
(define (transpose mat)
    (accumulate-n cons '() mat))

;矩阵乘法
(define (matrix-*-matrix m n)
    (let ((colse (transpose n)))
        (map (lambda (x) (matrix-*-vector colse x)) m)))