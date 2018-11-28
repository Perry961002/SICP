(load "Chap1\\example\\exa1.2.2-Fib-and-CountChange.scm")
(define (square x) (* x x))
;计算值为奇数的叶子的平方和
(define (sum-odd-squares tree)
    (cond ((null? tree) 0)
          ((not (pair? tree))
            (if (odd? tree) (square tree) 0))
          (else (+ (sum-odd-squares (car tree))
                   (sum-odd-squares (cdr tree))))))
;(enumerate: tree leaves) ==> (filter: odd?) ==> (map: square) ==> (accumulate: +, 0)

;得到1到n项之间的所有偶数的斐波那契数的一个表
(define (even-fibs n)
    (define (next k)
        (if (> k n)
            '()
            (let ((f (fib k)))
                (if (even? f)
                    (cons f (next (+ k 1)))
                    (next (+ k 1))))))
    (next 0))
;(enumerate: integers) ==> (map: fib) ==> (filter: even?) ==> (accumulate: cons, ())
;-----------------------------------------------------------------------------------------------

;序列操作

;过滤一个序列, 选出其中满足某个给定谓词的元素
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
           (cons (car sequence)
                 (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

;累积工作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

;生成一个整数的序列
(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

;枚举一棵树的所有树叶
(define (enumerate-tree tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree))))))

;重写sum-odd-squares过程
(define (sum-odd-squares tree)
    (accumulate +
                0
                (map square 
                     (filter odd? 
                             (enumerate-tree tree)))))

;重写even-fibs
(define (even-fibs n)
    (accumulate cons
                '()
                (filter even?
                        (map fib
                             (enumerate-interval 0 n)))))

;构造前n+1个斐波那契的平方和
(define (list-fib-squares n)
    (accumulate cons
                '()
                (map square
                     (map fib
                          (enumerate-interval 0 n)))))

;序列中所有奇数的平方的乘积
(define (product-of-squares-of-odd-elements sequence)
    (accumulate *
                1
                (map square
                     (filter odd? sequence))))