(load "Chap2\\example\\exa2.2.3-Sequences-act-as-interfaces-to-conventions.scm")
;生成一个整数的序列
(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

;定义empty-board
(define empty-board '())

;将一个新的行列格局加入一个格局集合
(define (adjoin-position new-row k rest-of-qieens)
    (append (list (list k new-row)) rest-of-qieens))

;第k列的皇后相对于其他列的皇后是否安全
(define (safe? k position)
    (let ((k-row (cadar position)))
         (if (null? (filter (lambda (x) (or (= k-row (cadr x)) (= (abs (- k (car x))) (abs (- k-row (cadr x))))))
                            (cdr position)))
             #t
             #f)))

;求解过程
(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter 
                (lambda (position) (safe? k position))
                (flatmap
                    (lambda (rest-of-qieens)
                        (map (lambda (new-row)
                                (adjoin-position new-row k rest-of-qieens))
                             (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))