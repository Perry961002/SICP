(define (install-polynomial-package)
    ;...
    (put '=zero? 'polynomial
        (lambda (x)
            (if (number? x)
                (= x 0)
                (empty-termlist? (term-list x)))))
    'done)