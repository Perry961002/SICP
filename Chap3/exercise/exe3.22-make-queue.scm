;将队列构造成一个带有局部状态的过程
(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))
        (define (set-front-ptr! item) (set! front-ptr item))
        
        (define (set-rear-ptr! item) (set! rear-ptr item))

        (define (empty-queue?) (null? front-ptr))

        (define (front-queue)
            (if (empty-queue?)
                "FRONT called with an empty queue"
                (car front-ptr)))

        (define (insert-queue! item)
            (let ((new-pair (cons item '())))
                (cond ((empty-queue?)
                       (set-front-ptr! new-pair)
                       (set-rear-ptr! new-pair)
                       front-ptr)
                      (else
                        (set-cdr! rear-ptr new-pair)
                        (set-rear-ptr! new-pair)
                        front-ptr))))

        (define (delete-queue!)
            (cond ((empty-queue?)
                   "DELETE! called with an empty queue")
                  (else
                    (set-front-ptr! (cdr front-ptr))
                    front-ptr)))

        (define (dispatch m)
            (cond ((eq? m 'empty-queue?) (empty-queue?))
                  ((eq? m 'front-queue) (front-queue))
                  ((eq? m 'insert-queue!) insert-queue!)
                  ((eq? m 'delete-queue!) (delete-queue!))
                  (else
                    (error "Undefined operation -- MAKE-QUEUE" m))))
        
        dispatch))

(define (empty-queue? queue) (queue 'empty-queue?))

(define (front-queue queue) (queue 'front-queue))

(define (insert-queue! queue item) ((queue 'insert-queue!) item))

(define (delete-queue! queue) (queue 'delete-queue!))