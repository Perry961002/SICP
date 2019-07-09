(define (simple-stream-flatmap proc s)
    (simple-flatmap (stream-map proc s)))

; 因为只可能产生空流或者只含一个元素的流，对于空流来说只需要过滤掉即可，对于只含一个元素的流只需要把元素取出即可
(define (simple-flatmap stream)
    (stream-map stream-car
                (stream-filter (lambda (s)
                                    (not (stream-null? s)))
                               stream)))

; b)
; 对查询结果没有影响