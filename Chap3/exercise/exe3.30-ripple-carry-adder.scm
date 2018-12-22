(load "Chap3\\example\\exa3.3.4-digital-circuit.scm")

; n位的级联进位加法器
(define (ripple-carry-adder A-list B-list S-list C)
    (define iter A B S value-c)
        (if (null? A)
            'ok
            (let ((Ak (car A))
                  (Bk (car B))
                  (Sk (car S))
                  (Ck (make-wire)))
                (set-signal! Ck value-c)
                (full-adder Ak Bk Ck Sk C)
                (iter (cdr A) (cdr B) (cdr S) (get-signal C))))
    (iter A-list B-list S-list (get-signal C)))

; 级联进位加法器由n个 full-adder 组成；而每个 full-adder 又由两个 half-adder 和一个 or-gate 组成；
; 而每个 half-adder 又由一个 or-gate ，一个 inveter 以及两个 and-gate 组成
; full-adder-delay = or-gate-delay + 2 * half-adder-delay
;                  = or-gate-delay + 2 * (or-gate-delay + inverter-delay + 2 * and-gate-delay)
;                  = (3 * or-gate-delay) + (2 * inveter-delay) + (4 * and-gate-delay)