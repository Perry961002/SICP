;以一个树为参数, 返回一个以这棵树所有树叶为元素的表
(define (fringe x)
    (cond ((null? x) '())
          ((not (pair? x)) (list x))
          (else 
            (append (fringe (car x))
                    (fringe (cdr x))))))