;累积工作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

;accumulate-n过程
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map (lambda (x)
                                               (if (null? x)
                                                   '()
                                                   (car x)))
                                        seqs))
              (accumulate-n op init (map (lambda (x)
                                                 (if (null? x)
                                                     '()
                                                     (cdr x)))
                                         seqs)))))