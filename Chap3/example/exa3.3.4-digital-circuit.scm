(load "Chap3\\example\\exa3.3.2-queue.scm")
(load "Chap3\\exercise\\exe3.28-or-gate.scm")

;待处理表的实现

;这种待处理表由一些时间段组成，每个时间段是由一个数值和一个队列组成的序对
(define (make-time-segment time queue)
    (cons time queue))

(define (segment-time s) (car s))

(define (segment-queue s) (cdr s))

;待处理表本身就是时间段的一个一维表格，时间段按时间递增的顺序
(define (make-agenda) (list 0))

(define (current-time agenda) (car agenda))

(define (set-current-time! agenda time)
    (set-car! agenda time))

(define (segments agenda) (cdr agenda))

(define (set-segments! agenda segments)
    (set-cdr! agenda segments))

(define (first-segment agenda) (car (segments agenda)))

(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)
    (null? (segments agenda)))

;将一个动作加入待处理的表
(define (add-to-agenda! time action agenda)
    (define (belongs-before? segments)
        (or (null? segments)
            (< time (segment-time (car segments)))))
    (define (make-new-time-segment time action)
        (let ((q (make-queue)))
            (insert-queue! q action)
            (make-time-segment time q)))
    (define (add-to-segments! segments)
        (if (= (segment-time (car segments)) time)
            (insert-queue! (segment-queue (car segments))
                           action)
            (let ((rest (cdr segments)))
                (if (belongs-before? rest)
                    (set-cdr!
                        segments
                        (cons (make-new-time-segment time action)
                              (cdr segments)))
                    (add-to-segments! rest)))))
    (let ((segments (segments agenda)))
        (if (belongs-before? segments)
            (set-segments!
                agenda
                (cons (make-new-time-segment time action)
                      segments))
            (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
    (let ((q (segment-queue (first-segment agenda))))
        (delete-queue! q)
        (if (empty-queue? q)
            (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
    (if (empty-agenda? agenda)
        (error "Agenda is empty -- FIRST-ACENDA-ITEM")
        (let ((first-seg (first-segment agenda)))
            (set-current-time! agenda (segment-time first-seg))
            (front-queue (segment-queue first-seg)))))
;------------------------------------------------------------------
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

;初始化处理表
(define the-agenda (make-agenda))

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

;------------------------------------------------------------------
;------------------------------------------------------------------------
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

;初始化描述各种功能块的延时
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

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
            (after-delay and-gate-delay
                         (lambda ()
                            (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)

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