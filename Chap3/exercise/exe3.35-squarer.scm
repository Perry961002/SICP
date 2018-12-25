(load "Chap3\\example\\exa3.3.5-make-connector.scm")

(define (squarer a b)
    (define (process-new-value)
        (if (has-value? b)
            (if (< (get-value b) 0)
                (error "square less than 0 -- SQUARER" (get-value b))
                (set-value! a
                            (sqrt (get-value b))
                            me))
            (if (has-value? a)
                (set-value! b
                            (* (get-value a) (get-value a))
                            me))))
    (define (process-forget-value)
        (forget-value! a me)
        (forget-value! b me)
        (process-new-value))
    (define (me request)
        (cond ((eq? request 'I-have-a-value)
               (process-new-value))
              ((eq? request 'I-lost-my-value)
               (process-forget-value))
              (else
                (error "Unknown request -- SQUARER" request))))
    (connect a me)
    (connect b me)
    me)

;测试
(define a (make-connector))
(define b (make-connector))

(squarer a b)
(probe 'a a)
(probe 'b b)

(set-value! a 3 'user)
;Probe: a = 3
;Probe: b = 9

(forget-value! a 'user)
;Probe: a = ?
;Probe: b = ?

(set-value! b 16 'user)
;Probe: b = 16
;Probe: a = 4