;累积工作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

;重写map过程
(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

;重写append过程
(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

;重写length过程
(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))