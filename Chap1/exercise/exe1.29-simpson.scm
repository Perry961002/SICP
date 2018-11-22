(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b) )))

;辛普森规则
(define (simpson f a b n)
    (define h (/ (- b a) n)) ;h
    (define (even? n) (= (remainder n 2) 0)) ;判断是不是偶数
    (define (term-g k)
        (cond ((= k 0) (f a))
              ((= k n) (f b))
              ((even? k) (* 2 (f (+ a (* k h)))))
              (else (* 4 
                       (f (+ a (* k h)))))))
    (define (inc n) (+ n 1))
    (* (sum term-g 0 inc n)
       (/ h 3.0)))