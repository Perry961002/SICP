;统计树中树叶的个数
(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1)
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

;树tree中的每个数值都乘以factor
(define (scale-tree tree factor)
    (cond ((null? tree) '())
          ((not (pair? tree)) (* tree factor))
          (else 
            (cons (scale-tree (car tree) factor)
                  (scale-tree (cdr tree) factor)))))

;用map迭代实现
(define (scale-tree tree factor)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (scale-tree sub-tree factor)
                (* sub-tree factor)))
         tree))