;因为队列是一个序对，它的car指针指向表的第一个数据项，cdr指针指向最后一个数据项，所以输出了那样的结果

(load "Chap3\\example\\exa3.3.2-queue.scm")
;所以要正确打印队列的话只需输出car所指的表即可
(define (print-queue queue)
    (if (empty-queue? queue)
        '()
        (front-ptr queue)))