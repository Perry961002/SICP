;权重函数
(define (weight x)
    (let ((i (car x)) (j (cadr x)))
        (+ (square i) (square j))))

;权重是否相等
(define (same-weight? x y z)
    (= (weight x) (weight y) (weight z)))

;顺序的序对流        
(define stream
    (weight-pairs integers integers weight))

(define (make-pairs pairs)
    (let ((first (stream-car pairs))
          (second (stream-car (stream-cdr pairs)))
          (third (stream-car (stream-cdr (stream-cdr pairs)))))
        (if (same-weight? first second third)
            (stream-cons (list (weight first) first second third)
                         (make-pairs (stream-cdr (stream-cdr (stream-cdr pairs)))))
            (make-pairs (stream-cdr pairs)))))

(define three-ways
    (make-pairs stream))

(display-top10 three-ways)
;(325 (1 18) (6 17) (10 15))  
;(425 (5 20) (8 19) (13 16))  
;(650 (5 25) (11 23) (17 19))  
;(725 (7 26) (10 25) (14 23))  
;(845 (2 29) (13 26) (19 22))  
;(850 (3 29) (11 27) (15 25))  
;(925 (5 30) (14 27) (21 22))  
;(1025 (1 32) (8 31) (20 25))  
;(1105 (4 33) (9 32) (12 31))  