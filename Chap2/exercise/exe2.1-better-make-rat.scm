(load "Chap1\\example\\exa1.2.5-GCD.scm")

;构造有理数
(define (make-rat n d)
    (cond ((and (> n 0) (< d 0))
           (let ((g (gcd n (- d))))
                (cons (- (/ n g)) (/ (- d) g))))
          ((and (< n 0) (> d 0))
            (let ((g (gcd (- n) d)))
                (cons (/ n g) (/ d g))))
          (else 
            (let ((g (gcd n d)))
                (cons (/ n g) (/ d g))))))