; s是否只有一个元素
(define (singleton-stream? s)
    (and (not (stream-null? s))
         (stream-null? (cdr s))))

(define (uniquely-asserted pattern frame-stream)
    (stream-flatmap
        (lambda (frame)
            (let ((stream (qeval pattern
                                 (singleton-stream frame))))
                (if (singleton-stream? stream)
                    stream
                    the-empty-stream)))
        frame-stream))