;定义: if n < 3, f(n) = n
;       else f(n) = f(n-1) + 2f(n-2) + 3f(n-3)

;使用递归计算过程
(define (fun-recursion n)
    (if (< n 3)
        n
        (+ (fun-recursion (- n 1))
            (* 2 (fun-recursion (- n 2)))
            (* 3 (fun-recursion (- n 3))))))

;使用迭代计算过程
(define (fun-iter first second third count)
    (cond ((= count 0) first)
          ((= count 1) second)
          ((= count 2) third)
          (else (fun-iter second
                          third
                          (+ third
                             (* 2 second)
                             (* 3 first))
                          (- count 1)))))
(define (fun n)
    (fun-iter 0 1 2 n))