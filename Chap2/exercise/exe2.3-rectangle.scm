(load "Chap2\\exercise\\exe2.2-segment.scm")
(load "Chap1\\example\\exa1.1.7-sqrt.scm")
;点p, q的距离
(define (distance p q)
    (sqrt (+ (square (- (car p) (car q)))
             (square (- (cdr p) (cdr q))))))
;用边表示矩形
(define (make-rectangle-segment length width)
    (cons length width))
;得到矩形的长
(define (length-rectangle r)
    (distance (car (car r)) (cdr (car r))))
;得到矩形的宽
(define (width-rectangle r)
    (distance (car (cdr r)) (cdr (cdr r))))
;-----------------------------------------------
;用相邻的三个点表示矩形
(define (make-rectangle-point a b c)
    (cons a (cons b c)))
;得到矩形的长
(define (len-rectangle r)
    (distance (car r) (car (cdr r))))
;得到矩形的宽
(define (wid-rectangle r)
    (distance (car (cdr r)) (cdr (cdr r))))
;------------------------------------------------
;计算矩形的周长
(define (perimeter-rectangle length width)
    (* (+ length width) 2))
;计算矩形的面积
(define (area-rectangle length width)
    (* length width))