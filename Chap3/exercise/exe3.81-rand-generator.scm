(define (rand-update x)
  (let ((a (expt 2 32))
        (c 1103515245)
        (m 12345))
    (modulo (+ (* a x) c) m)))

(define random-init 137)

;仔细想想输入的操作流对于generate命令，输入的就是一个字符，而reset应该是一个序对(cons reset new-num)
(define (rand-generator command-stream)
    (define (execute-command num commands)
        (let ((command (stream-car commands)))
            (cond ((eq? command 'generate)
                   (stream-cons 
                        num
                        (execute-command (rand-update num)
                                         (stream-cdr commands))))
                  ((pair? command)
                   (if (eq? (car command) 'reset) ;reset
                       (stream-cons
                            (cdr command)
                            (execute-command (rand-update (cdr command))
                                             (stream-cdr commands)))
                       (error "Unknown request" command)))
                  (else
                    (error "Unkonwn command" command)))))
    (execute-command random-init command-stream))

;测试
;命令流
(define gen-stream
    (stream-cons
        'generate
        (stream-cons
            'generate
            (stream-cons
                'generate
                (stream-cons
                    (cons 'reset 120)
                    (stream-cons
                        'generate
                        (stream-cons
                            'generate
                             gen-stream)))))))
;随机数流
(define rands (rand-generator gen-stream))

(display-top10 rands)
;137  3062  1397  120  12150  10620  1425  4380  9915