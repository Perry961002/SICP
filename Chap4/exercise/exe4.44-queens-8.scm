; 用(list q1 q2 ... q8)表示一个正确解，其中qi表示第i行的皇后放在第qi列

;用distinct?检测同列上有没有冲突
(define (distinct? items)
    (cond ((null? items) #t)
          ((null? (cdr items)) #t)
          ((member (car items) (cdr items)) #f)
          (else (distinct? (cdr items)))))

;判断对角线上有没有冲突
(define (two-in-diagonal? queens)
    (define (iter nums index items)
        (cond ((null? items) (> nums 1))
              ((= index (car items))
               (set! nums (+ nums 1))
               (if (> nums 1)
                   #t
                   (iter nums (+ index 1) (cdr items))))
              (else (iter nums (+ index 1) (cdr items)))))
    (iter 0 1 queens))

(define (collide? queens)
    (or (distinct? queens) (two-in-diagonal? queens)))

;采用非确定性计算求解8皇后问题
(define (eight-queens)
    (let ((q1 (amb 1 2 3 4 5 6 7 8))
          (q2 (amb 1 2 3 4 5 6 7 8))
          (q3 (amb 1 2 3 4 5 6 7 8))
          (q4 (amb 1 2 3 4 5 6 7 8))
          (q5 (amb 1 2 3 4 5 6 7 8))
          (q6 (amb 1 2 3 4 5 6 7 8))
          (q7 (amb 1 2 3 4 5 6 7 8))
          (q8 (amb 1 2 3 4 5 6 7 8)))
        (let ((queens (list q1 q2 q3 q4 q5 q6 q7 q8)))
            (require (not (distinct? queens)))
            (require (not (two-in-diagonal? queens)))
            queens)))