;下面将说明代换模型这种漂亮数学性质的简单模型，不可能继续适合作为处理程序设计语言里的对象和赋值的框架了

;使用赋值的过程
(define (make-simplified-withdraw balance)
    (lambda (amount)
        (set! balance (- balance amount))
        balance))

;不使用赋值的过程
(define (make-decrementer balance)
    (lambda (amount) (- balance amount)))

;用代换模型解释make-decrementer如何工作
;((make-decrementer 25) 20)
;((lambda (amount) (- 25 amount)) 20)
;(- 25 20)
;5

;尝试用代换模型去解释make-simplified-withdraw
;((make-simplified-withdraw 25) 20)
;((lambda (amount) (set! balance (- 25 amount)) 25) 20)
;(set! balance (- 25 20)) 25
;25

;代换的最终基础是，这一语言里的符号不过是作为值的名字。
;一旦引进了赋值的想法，一个变量就不再是一个简单的名字，现在的一个变量索引着一个可以保存值的位置，而存储在那里的值也是可以改变的
;------------------------------------------------------------------------------------------------------------------------

;同一和变化

(define d1 (make-decrementer 25))
(define d2 (make-decrementer 25))
;我们称d1和d2是同一的，因为d1和d2有相同的计算行为---都是同样的将会进行25-输入的运算
;事实上，我们确实可以在任何计算中用d1替代d2而不会改变结果

(define w1 (make-simplified-withdraw 25))
(define w2 (make-simplified-withdraw 25))

(w1 20) ;5
(w1 20) ;-15
(w2 20) ;5
;虽然w1和w2都是对同样表达式的求值创建起来的东西，从这个角度可以说他们是同一的
;但是如果说在任何表达式里都可以用w1代替w2，而不会改变表达式的求值结果，那就不对了
