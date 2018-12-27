(load "Chap3\\example\\exa3.5.1-stream-as-delay-table.scm")

(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream
            (apply proc (map stream-car argstreams))
            (apply stream-map
                   (cons proc (map stream-cdr argstreams))))))

;测试
(define a (stream-enumerate-interval 1 10))
(define b (stream-enumerate-interval 11 20))
(define c (stream-enumerate-interval 21 30))
(define x (stream-map + a b c))
(display-stream x)