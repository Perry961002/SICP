;抽象过程tree-map

;第一种定义
(define (tree-map proc tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (proc tree))
          (else 
            (cons (tree-map proc (car tree))
                  (tree-map proc (cdr tree))))))

;第二种定义
(define (tree-map proc tree)
    (map (lambda (x)
            (if (pair? x)
                (tree-map proc x)
                (proc x)))
         tree))