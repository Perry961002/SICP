;队列的表示方式：将队列表示为一个表，并带有一个指向表的最后序对的指针

;front-ptr，返回队头指针
(define (front-ptr queue) (car queue))

;rear-ptr，返回队尾指针
(define (rear-ptr queue) (cdr queue))

;修改两个指针
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

;判断队列是否为空，如果一个队列的前端指针等于末端指针，那么就认为队空
(define (empty-queue? queue) (null? (front-ptr queue)))

;构造函数
(define (make-queue) (cons '() '()))

;选择函数，得到队列前端的数据项
(define (front-queue queue)
    (if (empty-queue? queue)
        (error "FRONT called with an empty queue" queue)
        (car (front-ptr queue))))

;向队列插入数据项
(define (insert-queue! queue item)
    (let ((new-pair (cons item '())))
        (cond ((empty-queue? queue)
               (set-front-ptr! queue new-pair)
               (set-rear-ptr! queue new-pair)
               queue)
              (else
                (set-cdr! (rear-ptr queue) new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))

;删除队列前端的数据项
(define (delete-queue! queue)
    (cond ((empty-queue? queue)
           (error "DELETE! called with an empty queue" queue))
          (else
            (set-front-ptr! queue (cdr (front-ptr queue)))
            queue)))