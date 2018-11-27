;二叉活动体构造
(define (make-mobile left right)
    (list left right))

;分支构造
(define (make-branch length structure)
    (list length structure))

;-------------------------------------------------------------------
;测试用例:
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(define b (make-mobile (make-branch 2 3) (make-branch 4 5)))
(define c (make-mobile (make-branch 5 a) (make-branch 6 b)))
(define d (make-mobile (make-branch 10 a) (make-branch 12 5)))
;--------------------------------------------------------------------
; a)
;返回活动体的分支
(define (left-branch x)
    (car x))

(define (right-branch x)
    (car (cdr x)))

;返回分支的高度和structure
(define (branch-length x)
    (car x))

(define (branch-structure x)
    (car (cdr x)))
;------------------------------------------------------------------------
; b)
;返回活动体的总重量
(define (total-weight x)
    (let ((lb (left-branch x))
          (rb (right-branch x)))
         (cond 
            ((and (not (pair? (branch-structure lb))) (not (pair? (branch-structure rb)))) ; structure都是重量
             (+ (branch-structure lb) (branch-structure rb)))
            ((and (not (pair? (branch-structure lb))) (pair? (branch-structure rb))) ;左边是重量, 右边是活动体
             (+ (branch-structure) (total-weight (branch-structure rb))))
            ((and (pair? (branch-structure lb)) (not (pair? (branch-structure rb)))) ;;左边是活动体, 右边是重量
             (+ (total-weight (branch-structure lb)) (branch-structure rb)))
            (else 
                (+ (total-weight (branch-structure lb)) (total-weight (branch-structure rb)))))))
;--------------------------------------------------------------------------------------------------------------------
; c)
;得到分支的力矩
(define (branch-torque x)
    (define (branch-weight bra)
        (if (pair? (branch-structure bra))
            (total-weight (branch-structure bra))
            (branch-structure bra)))
    (* (branch-length x) (branch-weight x)))

;分支是否平衡
(define (branch-balance? bra)
    (if (pair? (branch-structure bra)) ;srtucture是一个活动体
        (mobile-balance? (branch-structure bra))
        #t))

;活动体是否平衡
(define (mobile-balance? x)
    (and (= (branch-torque (left-branch x)) ; 分支平衡
            (branch-torque (right-branch x)))
         (branch-balance? (left-branch x)) ;分支上的活动体也平衡
         (branch-balance? (right-branch x))))
;--------------------------------------------------------------------------
; d)
(define (make-mobile left right)
    (cons left right))

(define (make-branch length structure)
    (cons length structure))

; right-branch需要改写
(define (right-branch x)
    (cdr x))

; branch-structure需要改写
(define (branch-structure x)
    (cdr x))