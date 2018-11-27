(define (square x) (* x x))

;第一种定义
(define (square-tree items)
    (cond ((null? items) '())
          ((not (pair? items)) (square items))
          (else 
            (cons (square-tree (car items))
                  (square-tree (cdr items))))))

;第二种定义
(define (square-tree items)
    (map (lambda (x)
            (if (pair? x)
                (square-tree x)
                (square x)))
         items))