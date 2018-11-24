(define (interative-improve good-enough? improve)
    (define (try guess)
        (let ((next (improve guess)))
            (if (good-enough? guess next)
                next
                (try next))))
    (lambda (first-guess) (try first-guess)))

(define (fixed-point f first-guess)
    (define (good-enough? v1 v2)
        (< (abs (- v1 v2)) 0.00001))
    ((interative-improve good-enough? f) first-guess))