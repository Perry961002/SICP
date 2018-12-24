;半加器
(define (half-adder a b s c)
    (let ((d (make-wire))
          (e (make-wire)))
        (or-gate a b d)
        (add-gate a b c)
        (inverter c e)
        (add-gate d e s)
        'ok))

;全加器
(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire))
          (c1 (make-wire))
          (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)
        'ok))

;换流器
(define (logical-not s)
    (cond ((= s 0) 1)
          ((= s 1) 0)
          (else (error "Invalid signal" s))))
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay inverter-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! input invert-input)
    'ok)

;与门
(define (logical-and x y)
    (if (and (= x 1) (= y 1))
        1
        0))
(define (add-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value
                (logical-and (get-signal a1) (get-signal a2))))
            (after-delay and-gate-dely
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

;线路的表示
;一条线路是一个具有两个局部状态变量的计算对象，其中一个是信号值signal-value，另一个是一组过程action-procedures
(define (make-wire)
    (let ((signal-value 0) (action-procedures '()))
        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin (set! signal-value new-value)
                       (call-each action-procedures))
                'done))
        (define (accept-action-procedure! proc)
            (set! action-procedures (cons proc action-procedures))
            (proc))
        (define (dispatch m)
            (cond ((eq? m 'get-signal) signal-value)
                  ((eq? m 'set-signal!) set-my-signal!)
                  ((eq? m 'add-action!) accept-action-procedure!)
                  (else (error "Unknown operation -- WIRE" m))))
        dispatch))
;逐个调用一个无参过程表中的每个过程
(define (call-each procedures)
    (if (null? procedures)
        'done
        (begin
            ((car procedures))
            (call-each (cdr procedures)))))

(define (get-signal wire) (wire 'get-signal))

(define (set-signal! wire new-value)
    ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
    ((wire 'add-action!) action-procedure))
;------------------------------------------------------------------------

;待处理表
(define (after-delay delay action)
    (add-to-agenda! (+ delay (current-time the-agenda))
                    action
                    the-agenda))

;用propagate驱动模拟
(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

;------------------------------------------------------------------------
;一个简单的实例模拟器

;监测器
(define (probe name wire)
    (add-action! wire
                 (lambda ()
                    (newline)
                    (display name)
                    (display " ")
                    (display (current-time the-agenda))
                    (display "  New-value = ")
                    (display (get-signal wire)))))

;初始化处理表和描述各种功能块的延时
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-dely 3)
(define or-gate 5)

;定义4条线路，并安装监测器
(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)
(probe 'carry carry)

;将线路连接到半加器上
(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)

(propagate)

(set-signal! input-2 1)

(propagate)
;------------------------------------------------------------------
;待处理表的实现\

;这种待处理表由一些时间段组成，每个时间段是由一个数值和一个队列组成的序对
(define (make-time-segment time queue)
    (cons time queue))

(define (segment-time s) (car s))

(define (segment-queue s) (cdr s))