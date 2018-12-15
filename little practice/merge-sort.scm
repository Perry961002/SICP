;归并排序

;合并两个有序集合
(define (merge L1 L2)
    (cond ((null? L1) L2)
          ((null? L2) L1)
          (else
            (let ((x1 (car L1)) (x2 (car L2)))
                (if (<= x1 x2)
                    (cons x1 (merge (cdr L1) L2))
                    (cons x2 (merge L1 (cdr L2))))))))

;反复合并两个集合，直到合成一个
(define (merge-sort L)
    (define (transform x)
        (if (number? x)
            (list x)
            x))
    (cond ((null? L) '())
          ((= (length L) 1) (car L))
          (else
            (let ((l1 (transform (car L)))
                  (l2 (transform (cadr L))))
                (let ((new (list (merge l1 l2))))
                    (merge-sort (append (cddr L) new)))))))