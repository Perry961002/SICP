(load "Chap2\\exercise\\exe2.35-count-leaves.scm")
(load "Chap2\\exercise\\exe2.40-unique-pairs.scm")
;生成一个整数的序列
(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

;生成<=n的有序三元组
(define (unique-3-pairs n)
    (accumulate append '() (map (lambda (i) 
                                    (map (lambda (x) 
                                            (append (list i) x)) 
                                         (unique-pairs (- i 1)))) 
                                (enumerate-interval 1 n))))

;过滤器
(define (pairs-s n s)
    (filter (lambda (x) (= (+ (car x) (cadr x) (caddr x)) s)) (unique-3-pairs n)))