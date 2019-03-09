;(amb <e1><e2>...<en>)非确定地返回n个<ei>其中的一个值

;某个特定谓词必须为真
(define (require p)
    (if (not p) (amb)))

;使用amb解释器选出一个元素
(define (an-element-of items)
    (require (not (null? items)))
    (amb (car items) (an-element-of (cdr items))))

;返回任何一个大于或等于n的整数
(define (an-integer-starting-from n)
    (amb n (an-integer-starting-from (+ n 1))))