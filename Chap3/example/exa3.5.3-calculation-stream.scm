;无穷的猜测序列
(define (average x y) 
    (/ (+ x y) 2))

(define (sqrt-improve guess x) 
    (average guess (/ x guess)))

(define (sqrt-stream x)
    (define guess
        (stream-cons 1.0
                     (stream-map (lambda (guess)
                                    (sqrt-improve guess x))
                                 guess)))
    guess)

;用流得到pi的近似值
(define (pi-summands n)
    (stream-cons (/ 1.0 n)
                 (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
    (scale-stream (partial-sum (pi-summands 1)) 4))

(display-top10 pi-stream)
;4.0  2.666666666666667  3.466666666666667 
;2.8952380952380956  3.3396825396825403  
;2.9760461760461765  3.2837384837384844  
;3.017071817071818  3.2523659347188767

;序列加速器
(define (eular-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
        (stream-cons (- s2 (/ (square (- s2 s1))
                           (+ s0 (* -2 s1) s2)))
                     (eular-transform (stream-cdr s)))))

(display-top10 (eular-transform pi-stream))
;3.166666666666667  3.1333333333333337  
;3.1452380952380956  3.13968253968254  
;3.1427128427128435  3.1408813408813416  
;3.142071817071818  3.1412548236077655  3.1418396189294033

;超级加速器，构造流的流
(define (make-tableau transform s)
    (stream-cons s
                 (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car
                (make-tableau transform s)))
        
(display-top10 (accelerated-sequence eular-transform pi-stream))
;4.0  3.166666666666667  3.142105263157895  
;3.141599357319005  3.1415927140337785  
;3.1415926539752927  3.1415926535911765  
;3.141592653589778  3.1415926535897953  
;------------------------------------------------------------------
;序对的无穷流

;将两个序对交替取出
; s1,t1,s2,t2,...,si,ti,...
(define (interleave s t)
    (if (stream-empty? s)
        t
        (stream-cons (stream-car s)
                     (interleave t (stream-cdr s)))))

;序对流
(define (pairs s t)
    (stream-cons
        (list (stream-car s) (stream-car t))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) x))
                        (stream-cdr t))
            (pairs (stream-cdr s) (stream-cdr t)))))

;(display-top10 (pairs integers integers))
;(1 1)  (1 2)  (2 2)  (1 3)  (2 3)  (1 4)  (3 3)  (1 5)  (2 4) 
;----------------------------------------------------------------
;将流作为信号

;两个流相加
(define (add-streams s1 s2)
    (stream-map + s1 s2))

;积分器
(define (integral integrand initial-value dt)
    (define int
        (stream-cons initial-value
                     (add-streams (scale-stream integrand dt)
                                  int)))
    int)