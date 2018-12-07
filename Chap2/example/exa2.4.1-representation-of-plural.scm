;复数的加法和减法采用实部和虚部的方式描述，复数的乘法和除法采用模和幅角的方式描述
(define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
        
(define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
;--------------------------------------------------------------------------

;采用直角坐标形式表示复数
(define (square x) (* x x))

(define (real-part z) (car z))

(define (imag-part z) (cdr z))

(define (magnitude z)
    (sqrt (+ (square (real-part z)) (square (imag-part z)))))

(define (angle z)
    (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))

(define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
;--------------------------------------------------------------------------

;采用极坐标形式表示复数
(define (real-part z)
    (* (magnitude z) (cos (angle z))))

(define (imag-part z)
    (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

(define (make-from-mag-ang r a) (cons r a))