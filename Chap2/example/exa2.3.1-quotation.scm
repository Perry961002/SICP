;过程memg
;以一个符号和一个表为参数
;如果这个符号不包含在这个表里，就返回假；否则就返回这个符号第一次出现开始的那个子表
(define (memg item x)
    (cond ((null? x) #f)
          ((eq? item (car x)) x)
          (else
            (memg item (cdr x)))))