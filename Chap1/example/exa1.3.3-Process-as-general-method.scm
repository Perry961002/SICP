;通过区间折半寻找方程的根
(define (search f neg-point pos-point)
    (let ((mid-point ((lambda (x y) (/ (+ x y) 2)) neg-point pos-point)))
        (if (close-enough? neg-point pos-point)
            mid-point
            (let ((test-value (f mid-point)))
                (cond ((positive? test-value)
                       (search f neg-point mid-point))
                      ((negative? test-value)
                       (search f mid-point pos-point))
                      (else mid-point))))))

(define (close-enough? x y)
    (< (abs (- x y)) 0.00001))

(define (half-interval-method f a b)
    (let ((a-value (f a))
          (b-value (f b)))
        (cond ((and (negative? a-value) (positive? b-value))
               (search f a b))
              ((and (negative? b-value) (positive? a-value))
               (search f b a))
              (else 
                (error "Values are not of opposite sign" a b)))))
;******************************************************************************
;找出函数的不动点
(define (fixed-point f first-guess)
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))