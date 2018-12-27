(load "Chap3\\exercise\\exe3.47-make-semaphore.scm")

(define (exchange account1 account2)
        (let ((difference (- (account1 'balance)
                             (account2 'balance))))
            ((account1 'withdraw) difference)
            ((account2 'deposit) difference)))

(define (set-id)
    (let ((i 0))
        (lambda ()  ;返回一个过程，把编号加一，并返回
            (set! i (+ i 1))
            i)))

;分配id
(define make-id (set-id))
;测试
; (define a (make-id))
; a ;==> 1
; a ;==> 1
; (define b (make-id))
; b ;==> 2
; b ;==> 2

(define (make-account balance)
    (let ((id (make-id)))
        (define (withdraw amount)
            (if (>= balance amount)
                (begin (set! balance (- balance amount))
                       balance)
                "Insufficient funds"))
        (define (deposit amount)
            (set! balance (+ balance amount))
            balance)
        (let ((balance-serializer (make-serializer)))
            (define (dispatch m)
                (cond
                    ((eq? m 'withdraw) withdraw)
                    ((eq? m 'deposit) deposit)
                    ((eq? m 'balance) balance)
                    ((eq? m 'serializer) balance-serializer)
                    ((eq? m 'id) id)
                    (else (error "Unknown request -- MAKE_ACCOUNT" m))))
            dispatch)))

(define (serialized-exchange account1 account2)
    (let ((id1 (account1 'id)) (id2 (account2 'id))
          (ser1 (account1 'serializer)) (ser2 (account2 'serializer)))
        (if (< id1 id2)
            ((ser1 (ser2 exchange)) account1 account2)
            ((ser2 (ser1 exchange)) account1 account2))))

;测试
(define acc1 (make-account 100))
(define acc2 (make-account 60))
(serialized-exchange acc1 acc2)
;100
;(acc1 'balance) ==> 60