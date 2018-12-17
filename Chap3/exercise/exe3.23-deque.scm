;首先要给出deque的表示方式，这里要借助queue的表示方式。
;对queue的表x，对其中的每个序对pi，把car指针指向一个序对，这个序对的car就是数据值，cdr指向前一个序对p(i-1)，i > 1。

(define (front-ptr deque) (car deque))

(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item) (set-car! deque item))

(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (empty-deque? deque)
    (or (eq? (front-ptr deque) '())
        (eq? (rear-ptr deque) '())))

(define (make-deque) (cons '() '()))

(define (front-deque deque)
    (if (empty-deque? deque)
        (error "FRONT called with an empty deque" deque)
        (caar (front-ptr deque))))

(define (rear-deque deque)
    (if (empty-deque? deque)
        (error "REAR called with an empty deque" deque)
        (caar (rear-ptr deque))))

(define (print-deque deque)
    (define (iter p)
      (if (null? p)
          '()
          (cons (caar p) (iter (cdr p)))))
    (if (empty-deque? deque)
        '()
        (iter (front-ptr deque))))

(define (front-insert-deque! deque item)
    (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               (print-deque deque))
              (else
                (set-cdr! new-pair (front-ptr deque))
                (set-cdr! (car (front-ptr deque)) new-pair)
                (set-front-ptr! deque new-pair)
                (print-deque deque)))))

(define (rear-insert-deque! deque item)
    (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-pair)
               (set-rear-ptr! deque new-pair)
               (print-deque deque))
              (else
                (set-cdr! (rear-ptr deque) new-pair)
                (set-cdr! (car new-pair) (rear-ptr deque))
                (set-rear-ptr! deque new-pair)
                (print-deque deque)))))

(define (front-delete-deque! deque)
    (cond ((empty-deque? deque)
           (error "DELETE! called with an empty deque" deque))
          (else
            (set-front-ptr! deque (cdr (front-ptr deque)))
            (set-cdr! (car (front-ptr deque)) '())
            (print-deque deque))))

(define (rear-delete-deque! deque)
    (cond ((empty-deque? deque)
           (error "DELETE! called with an empty deque" deque))
          (else
            (set-rear-ptr! deque (cdar (rear-ptr deque)))
            (set-cdr! (rear-ptr deque) '())
            (print-deque deque))))