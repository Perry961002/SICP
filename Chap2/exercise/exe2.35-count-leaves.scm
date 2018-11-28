(load "Chap2\\exercise\\exe2.28-fringe.scm")
;累积工作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

;将count-leaves定义为一个累积
(define (count-leaves t)
    (accumulate (lambda (x y) (+ x y)) 0 (map (lambda (x) 1) (fringe t))))