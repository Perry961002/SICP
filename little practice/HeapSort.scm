;维护一个以root下标为根，末尾为len的堆
(define (MaxHeapify heap root len)
    (define (Left i) (+ (* i 2) 1))
    (define (Right i) (* (+ i 1) 2))
    (let ((left (Left root))
          (right (Right root))
          (largest root))
        (begin
            (if (and (<= left len)
                     (> (vector-ref heap left)
                        (vector-ref heap root)))
                (set! largest left))
            (if (and (<= right len)
                     (> (vector-ref heap right)
                        (vector-ref heap largest)))
                (set! largest right))
            (if (not (= largest root))
                (let ((head (vector-ref heap root)))
                    (begin
                        (vector-set! heap root (vector-ref heap largest))
                        (vector-set! heap largest head)
                        (MaxHeapify heap largest len)))))))

;对向量heap自底向上建大根堆
(define (BuildMaxHeap heap)
    (define (build-iter i)
        (if (>= i 0)
            (begin
                (MaxHeapify heap i (- (vector-length heap) 1))
                (build-iter (- i 1)))))
    (build-iter (- (div (vector-length heap) 2) 1)))

;堆排序
(define (HeapSort heap)
    (define (sort-iter i)
        (if (>= i 1)
            (let ((max (vector-ref heap 0)))
                (begin
                    (vector-set! heap 0 (vector-ref heap i))
                    (vector-set! heap i max)
                    (MaxHeapify heap 0 (- i 1))
                    (sort-iter (- i 1))))))
    (BuildMaxHeap heap)
    (sort-iter (- (vector-length heap) 1))
    heap)

;测试用例：
(define heap (vector 1 5 7 8 9 6 3 4 5 1 0 89 45 15 20 17 895 1 4 56 287 45 369 45 98 92 37 15 620 784 562 15 37 66))
(display (HeapSort heap)) ;#(0 1 1 1 3 4 4 5 5 6 7 8 9 15 15 15 17 20 37 37 45 45 45 56 66 89 92 98 287 369 562 620 784 895)