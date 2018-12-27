;delay和force的实现

;记忆化执行proc的过程
(define (memo-proc proc)
    (let ((already-run? #f) (result #f))
        (lambda ()
            (if (not already-run?)
                (begin (set! result (proc))
                       (set! already-run? #t)
                       result)
                result))))

;实现delay
(define (delay exp)
    (memo-proc (lambda () exp)))

;实现force
(define (force obj)
    (obj))

;实现cons-stream
(define (cons-stream a b)
    (cons a (delay b)))

(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

(define (stream-null? stream) (null? stream))

(define the-empty-stream '())

;流的第n项
(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

;流的映射
(define (stream-map proc s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream (proc (stream-car s))
                     (stream-map proc (stream-cdr s)))))

;for-each操作
(define (stream-for-each proc s)
    (if (stream-null? s)
        'done
        (begin (proc (stream-car s))
               (stream-for-each proc (stream-cdr s)))))

;打印
(define (display-line x)
    (newline)
    (display x))

(define (display-stream s)
    (stream-for-each display-line s))

;采用流，进行延迟计算的enumerate-interval和filter过程
(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream
            low
            (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
    (cond ((stream-null? stream) the-empty-stream)
          ((pred (stream-car stream))
           (cons-stream (stream-car stream)
                        (stream-filter pred (stream-cdr stream))))
          (else (stream-filter pred (stream-cdr stream)))))