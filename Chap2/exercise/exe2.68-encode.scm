(load "Chap2\\exercise\\exe2.67-decode.scm")

;过程memg
;以一个符号和一个表为参数
;如果这个符号不包含在这个表里，就返回假；否则就返回真
(define (memq item x)
    (if (null? x) 
        #f
        (or (eq? item (car x)) (memq item (cdr x)))))

;得到对象参数在Huffman树中对应的编码
(define (encode-symbol char tree)
    (cond ((null? tree)
           (error "No such character" char))
          ((leaf? tree) '())
          (else
            (let ((lb (left-branch tree))
                  (rb (right-branch tree)))
                (cond ((memq char (symbol lb))
                       (cons 0 (encode-symbol char lb)))
                      ((memq char (symbol rb))
                       (cons 1 (encode-symbol char rb)))
                      (else
                        (error "No such character" char)))))))

;编码过程
(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))

;测试用消息
(define sample-message '(A D A B B C A)) ;==> (0 1 1 0 0 1 0 1 0 1 1 1 0)