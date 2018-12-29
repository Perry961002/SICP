(define (cube x) (* x x x))

(define (weight x)
    (let ((i (car x)) (j (cadr x)))
        (+ (cube i)
           (cube j))))

;顺序的序对流        
(define stream
    (weight-pairs integers integers weight))

;两个序对的权重是不是一样
(define (same-weight? x y)
    (= (weight x) (weight y)))

(define (make-ramanujan pairs)
    (let ((first (stream-car pairs))
          (second (stream-car (stream-cdr pairs))))
        (if (same-weight? first second)
            (stream-cons (list (weight first) first second)
                         (make-ramanujan (stream-cdr (stream-cdr pairs)))) ;以两种方式写成两个立方之后，所以向后移两位
            (make-ramanujan (stream-cdr pairs))))) ;向后移一位
        
(define ramanujan
    (make-ramanujan stream))

(display-top10 ramanujan)
;(1729 (1 12) (9 10))  
;(4104 (2 16) (9 15))  
;(13832 (2 24) (18 20))  
;(20683 (10 27) (19 24))  
;(32832 (4 32) (18 30))  
;(39312 (2 34) (15 33))  
;(40033 (9 34) (16 33))  
;(46683 (3 36) (27 30))  
;(64232 (17 39) (26 36))