;for-each以一个过程和一个表为参数, 将proc从左到右应用于表中各个元素, 但不返回新表
(define (for-each proc items)
    (if (null? items)
        #t
        (begin
            (proc (car items))
            (for-each proc (cdr items)))))