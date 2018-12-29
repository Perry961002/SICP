(define (stream-limit s tolerance)
    (define (iter s)
        (let ((first (stream-car s))
              (second (stream-car (stream-cdr s))))
            (if (< (abs (- second first)) tolerance)
                second
                (iter (stream-cdr s)))))
    (iter s))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define tolerance 0.000000001)
(sqrt 2 tolerance)
; 1.414213562373095