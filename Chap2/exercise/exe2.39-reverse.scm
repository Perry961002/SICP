(load "Chap2\\exercise\\exe2.38-fold-left-and-fold-right.scm")

;重写reverse过程
;法一:
;(define (reverse sequence)
 ;   (fold-right (lambda (x y) (append y (list x))) '() sequence))

;法二:
(define (reverse sequence)
    (fold-left (lambda (x y) (append (list y) x)) '() sequence))