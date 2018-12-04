;平面上的一条直线段可以用一对向量表示:
;从原点到线段起点的向量, 从原点到线段终点的向量

;构造函数
(define (make-segment start end)
    (cons start end))

;选择函数
(define (start-segment s)
    (car s))

(define (end-segment s)
    (cdr s))