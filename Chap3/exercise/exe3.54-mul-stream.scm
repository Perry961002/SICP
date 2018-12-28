(load "Chap3\\example\\exa3.5.2-infinite-stream.scm")
(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define factorials (stream-cons 1 (mul-streams factorials (integers-starting-from 2))))