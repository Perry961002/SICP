;构造被加数的流
(define (ln2-summands n)
    (stream-cons (/ 1.0 n)
                 (stream-map - (ln2-summands (+ n 1)))))

;ln2的流
(define ln2-stream
    (partial-sum (ln2-summands 1)))

(display-top10 ln2-stream)
;1.0  0.5  0.8333333333333333  
;0.5833333333333333  0.7833333333333332  
;0.6166666666666666  0.7595238095238095  
;0.6345238095238095  0.7456349206349207

;加速器法
(define (eular-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
        (stream-cons (- s2 (/ (square (- s2 s1))
                           (+ s0 (* -2 s1) s2)))
                     (eular-transform (stream-cdr s)))))

(display-top10 (eular-transform ln2-stream))
;0.7  0.6904761904761905  0.6944444444444444  
;0.6924242424242424  0.6935897435897436  
;0.6928571428571428  0.6933473389355742  
;0.6930033416875522  0.6932539682539683

;超级加速器
(define (make-tableau transform s)
    (stream-cons s
                 (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car
                (make-tableau transform s)))

(display-top10 (accelerated-sequence eular-transform ln2-stream))
;1.0  0.7  0.6932773109243697  
;0.6931488693329254  0.6931471960735491  
;0.6931471806635636  0.6931471805604039  
;0.6931471805599445  0.6931471805599427

;明显的第三种方法收敛的最快，然后是第二种方法，最慢的是第一个。