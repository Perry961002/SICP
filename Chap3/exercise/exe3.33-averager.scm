(load "Chap3\\example\\exa3.3.5-make-connector.scm")

;平均约束，使 c = (a + b) / 2
(define (averager a b c)
    (let ((x (make-connector))
          (y (make-connector)))
        (adder a b y)
        (constant 2 x)
        (multiplier c x y)
        'ok))

;测试
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)

(probe "a temp" a)
(probe "b temp" b)
(probe "c temp" c)

(set-value! a 2 'user)
(set-value! b 4 'user)
;Probe: a temp = 2
;Probe: b temp = 4
;Probe: c temp = 3

(forget-value! a 'user)
;Probe: a temp = ?
;Probe: c temp = ?

(set-value! c 6 'user)
;Probe: c temp = 6
;Probe: a temp = 8