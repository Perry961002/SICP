(load "Chap2\\exercise\\exe2.35-count-leaves.scm")
(load "Chap2\\example\\exa2.2.3-Sequences-act-as-interfaces-to-conventions.scm")

;生成一个整数的序列
(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

;给定一个整数n, 产生序对(i, j)
(define (unique-pairs n)
    (accumulate append '() (map (lambda (i) 
                                    (map (lambda (j) (list i j))
                                    (enumerate-interval 1 (- i 1))))
                                (enumerate-interval 1 n))))

;重写prime-sum-pairs
(define (prime-sum-pairs n)
    (map make-pair-sum
         (filter prime-sum? (unique-pairs n))))