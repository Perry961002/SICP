;打印第i行, 第j列上的数
(define (pascal-num i j)
    (cond ((= j 1) 1)
          ((< j i) (+ (pascal-num (- i 1) (- j 1))
                      (pascal-num (- i 1) j)))
          (else 1)))

;打印一行的Pascal
(define (display-line-iter n count)
    (if (<= count n)
        (begin (display (pascal-num n count))
               (display " ")
               (display-line-iter n (+ count 1)))
        (display "\n")))

;迭代打印整个Pascal三角形
(define (display-pascal-iter n col)
    (if (<= col n)
        (begin (display-line-iter col 1)
               (display-pascal-iter n (+ col 1)))))

;打印Pascal
(define (pascal n) (display-pascal-iter n 1))