(define (merge-weighted s1 s2 weight)
    (cond ((stream-empty? s1) s2)
          ((stream-empty? s2) s1)
          (else
            (let ((w1 (weight (stream-car s1)))
                  (w2 (weight (stream-car s2))))
                (cond ((<= w1 w2)
                       (stream-cons (stream-car s1) 
                                    (merge-weighted (stream-cdr s1) s2 weight)))
                      (else
                       (stream-cons (stream-car s2)
                                    (merge-weighted s1 (stream-cdr s2) weight))))))))

;注意书下面的备注中给出的关于weight的说明，沿向下或向右时权重一定增加
(define (weight-pairs s t weight)
    (stream-cons
        (list (stream-car s) (stream-car t))
        (merge-weighted (stream-map (lambda (x) (list (stream-car s) x))
                                    (stream-cdr t))
                        (weight-pairs (stream-cdr s) (stream-cdr t) weight)
                        weight)))

; a)
(define (weight1 x) (+ (car x) (cadr x)))
(define p (weight-pairs integers integers weight1))
(display-top10 p)
;(1 1)  (1 2)  (1 3)  (2 2)  (1 4)  (2 3)  (1 5)  (2 4)  (3 3) 

; b)
(define (weight2 x)
    (let ((i (car x)) (j (cadr x)))
        (+ (* 2 i) (* 3 j) (* 5 i j))))
(define (divide? x y) (= (remainder x y) 0))
(define q
    (stream-filter (lambda (x)
                        (let ((i (car x)) (j (cadr x)))
                            (or (divide? i 2) (divide? j 3) (divide? i 5)
                                (divide? j 2) (divide? j 3) (divide? j 5))))
                   (weight-pairs integers integers weight2)))
(display-top10 q)
;(1 2)  (1 3)  (2 2)  (1 4)  (1 5)  (2 3)  (1 6)  (2 4)  (3 3)  