(define (same-parity first . others)
    (define (find others)
        (cond ((null? others) '()) ;others为空, 返回空表
              ((= (remainder first 2) (remainder (car others) 2)) ;others的第一个数符合要求, 递归下去
               (cons (car others) (find (cdr others))))
              (else
                (find (cdr others)))))
    (cons first (find others)))