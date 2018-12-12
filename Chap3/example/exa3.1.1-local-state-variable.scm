;所谓一个对象“有状态”，就是说他的行为受他的历史行为的影响
;使用局部状态变量创建过程make-withdraw，他是一个“提款处理器”
(define (make-withdraw balance)
    (lambda (amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds")))
;测试：
;(define W1 (make-withdraw 100))
;(define W2 (make-withdraw 100))
;(W1 20) ==> 80
;(W1 30) ==> 70

;返回一个具有给定初始余额的银行账户对象
(define (make-account balance)
    ;取款过程
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds"))
    ;存款
    (define (disposit amount)
        (set! balance (+ balance amount))
        balance)
    ;消息传递机制
    (define (dispatch m)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'disposit) disposit)
              (else (error "Unknow request -- MAKE-ACCOUNT" m))))
    dispatch)
;测试
;(define acc (make-account 100))
;((acc 'withdraw) 50) ==> 50
;((acc 'withdraw) 60) ==> "Insufficient funds"
;((acc 'disposit) 40) ==> 90
;((acc 'withdraw) 60) ==> 30
;(define acc2 (make-account 100))
;((acc2 'withdraw) 60) ==> 40