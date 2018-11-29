(load "Chap2\\exercise\\exe2.36-accumulate-n.scm")

;accumulate称为fold-right
(define (fold-right op inital sequence)
    (accumulate op inital sequence))

(define (fold-left op inital sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter inital sequence))

(fold-right / 1 (list 1 2 3)) ; 3/2
(fold-left / 1 (list 1 2 3)) ;1/6
(fold-right list '() (list 1 2 3)) ;(1 (2 (3 ())))
(fold-left list '() (list 1 2 3));(((() 1) 2) 3)
;当(op a b) = (op b a)时两种次序的结果相等