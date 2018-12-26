- 3.4.2控制并发的机制(串行化组)
    - 对共享变量的串行化访问
    ```
    (define (make-account balance)
        (define (withdraw amount)
            (if (>= balance amount)
            (begin
                (set! balance (- balance amount))
                balance)
            "Insufficient funds."))
        (define (deposit amount)
            (set! balance (+ balance amount))
            balance)

        (let ((protected (make-serializer)))
            (define (dispatch m)
            (cond
                ((eq? m 'withdraw) (protected withdraw))
                ((eq? m 'deposit) (protected deposit))
                ((eq? m 'balance) balance)
                (else (error "Unknown request -- MAKE-ACCOUNT" m))))
            dispatch))
    ```
- 使用多重共享资源的复杂性
    ```
    (define (exchange account1 account2)
        (let ((difference (- (account1 'balance)
                             (account2 'balance))))
            ((account1 'withdraw) difference)
            ((account2 'deposit) difference)))

    (define (make-account-and-serializer balance)
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
                (cond ((eq? m 'withdraw) withdraw)
                      ((eq? m 'deposit) deposit)
                      ((eq? m 'balance) balance)
                      ((eq? m 'serializer) balance-serializer)
                      (else (error "Unknown request -- MAKE-ACCOUNT" m))))
            dispatch))

    (define (deposit account amount)
        (let ((s (account 'serializer))
              (d (account 'deposit)))
        ((s d) amount)))

    (define (serialized-exchange account1 account2)
        (let ((serializer1 (account1 'serializer))
              (serializer2 (account2 'serializer)))
            ((serializer1 (serializer2 exchange))
             account1
             account2)))
    ```
- 串行化的实现
```
(define (clear! cell)
    (set-car! cell #f))

(define (test-and-set! cell)
    (if (car cell)
        #t
        (begin (set-car! cell #t)
               #f)))

(define (make-mutex)
    (let ((cell (list #f)))
        (define (the-mutex m)
            (cond ((eq? m 'acquire)
                   (if (test-and-set! cell)
                       (the-mutex 'acquire)))
                  ((eq? m 'release) (clear! cell))))
        the-mutex))

(define (make-serializer)
    (let ((mutex (make-mutex)))
        (lambda (p)
            (define (serialized-p . args)
                (mutex 'acquire)
                (let ((val (apply p args)))
                    (mutex 'release)
                    val))
            serialized-p)))
```