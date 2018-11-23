;k项有限连分式过程
(define (cont-frac N D k)
    (define (fun i)
        (if (= i k)
            (/ (N k) (D k))
            (/ (N i) 
               (+ (D i)
                  (fun (+ i 1))))))
    (fun 1))

;选择k有项连分式过程的实现方式计算黄金分割率, k = 13时保证近似值具有0.0001的精度
(define (golden-ratio kind-of-fun k)
    (/ 1.0 
       (kind-of-fun (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))
;----------------------------------------------------------------
;给出一个迭代版本的实现
(define (cont-frac-iter N D k)
    (define (iter i result)
        (if (= i 1)
            result
            (iter (- i 1) (/ (N (- i 1))
                             (+ (D (- i 1))
                                result)))))
    (iter k (/ (N k) (D k))))