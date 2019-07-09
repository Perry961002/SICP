(define input-prompt ";;; Query input:")
(define output-prompt ";;; Query output:")

;驱动循环
;如果表达式是规则或者断言，就把有关信息加入数据库
;否则就认为是查询, 将这个查询送给求值器qeval, 同时还有一个只包含空框架的框架流
;求值结果是一个框架流, 驱动循环使用这些框架产生一个新流, 包含了所有通过将原始查询里的变量用上述框架流提供的值实例化后得到的副本, 供终端打印
(define (query-driver-loop)
    (prompt-for-input input-prompt)
    (let ((q (query-syntax-process (read))))
        (cond ((assertion-to-be-added? q)
               (add-rule-or-assertion! (add-assertion-body q))
               (newline)
               (display "Assertion added to data base.")
               (query-driver-loop))
             (else
                (newline)
                (display output-prompt)
                (display-stream
                    (stream-map
                        (lambda (frame)
                            (instantiate q
                                         frame
                                         (lambda (v f)
                                            (contract-question-mark v))))
                    (qeval q (singleton-stream '()))))
                (query-driver-loop)))))

;实例化一个表达式
;我们需要复制它, 并用给定框架里的值取代这一表达式里相应的变量
;这些值本身也可能需要实例化
;如果某个变量不能被实例化, 接下来的动作由instantiate的另一个参数给定
(define (instantiate exp frame unbound-var-handler)
    (define (copy exp)
        (cond ((var? exp)
               (let ((binding (binding-in-frame exp frame)))
                (if binding
                    (copy (binding-value binding))
                    (unbound-var-handler exp frame))))
              ((pair? exp)
               (cons (copy (car exp)) (copy (cdr exp))))
              (else exp)))
    (copy exp))


;qeval是查询的基本求值器
;以一个查询和一个框架流作为输入, 返回被扩充后的框架流, 使用数据导向的分派方式
(define (qeval query frame-stream)
    (let ((qproc (get (type query) 'qeval)))
        (if qproc
            (qproc (contents query) frame-stream)
            (simple-query query frame-stream))))

;simple-query处理简单查询, 以简单查询和框架流作为实际参数, 通过将查询与数据库做匹配的方式扩充其中的每个框架
(define (simple-query query-pattern frame-stream)
    (stream-flatmap              ;组合每个输入框架产生的结果流
        (lambda (frame)
            (stream-append-delayed           ;组合两个流
                (find-assertions query-pattern frame)    ;做模式与数据库里所有断言的匹配
                (delay (apply-rules query-pattern frame))))    ;应用尽可能所有的规则
    frame-stream))


;处理复合查询

; 处理and
(define (conjoin conjuncts frame-stream)
    (if (empty-conjuncts? conjuncts)
        frame-stream
        (conjoin (rest-conjuncts conjuncts)
                 (qeval (first-conjunct conjuncts)
                        frame-stream))))
(put 'and 'qeval conjoin)

; 处理or
(define (disjoin disjuncts frame-stream)
    (if (empty-disjuncts? disjuncts)
        the-empty-stream
        (interleave-delayed
            (qeval (first-disjunct disjuncts) frame-stream)
            (delay (disjoin (rest-disjuncts disjuncts)
                            frame-stream)))))
(put 'or 'qeval disjoin)

; 处理not
(define (negate operands frame-stream)
    (stream-flatmap
        (lambda (frame)
            (if (stream-null? (qeval (negate-query operands)
                                     (singleton-stream frame)))
                (singleton-stream frame)
                the-empty-stream))
        frame-stream))
(put 'not 'qeval negate)

; 过滤器
(define (lisp-value call frame-stream)
    (stream-flatmap
        (lambda (frame)
            (if (execute
                    (instantiate
                        call
                        frame
                        (lambda (v f)
                            (error "Unknow pat var -- LISP-VALUE" v))))
                (singleton-stream frame)
                the-empty-stream))
        frame-stream))
(put 'lisp-value 'qeval lisp-value)

; execute将谓词应用与对应的参数
(define (execute exp)
    (apply (eval (predicate exp) user-initial-environment)
           (args exp)))

; 特殊形式always-true是为了描述一种总能满足的查询
(define (always-true ignore frame-stream) frame-stream)
(put 'always-true 'qeval always-true)

; find-assertions以一个模式和一个框架作为输入，返回一个框架流，其中每个框架都是由某个给定框架，经过对给定模式与数据库的匹配扩充得到的
(define (find-assertions pattern frame)
    (stream-flatmap (lambda (datum)
                        (check-an-assertion datum pattern frame))
                    (fetch-assertions pattern frame)))

; check-an-assertion以一个模式、一个数据对象和一个框架作为参数
; 如果匹配成功就返回包含着扩充框架的单元素流，失败就返回the-empty-stream
(define (check-an-assertion assertion query-pat query-frame)
    (let ((match-result
            (pattern-match query-pat assertion query-frame)))
        (if (eq? match-result 'failed)
            the-empty-stream
            (singleton-stream match-result))))

; 基本模式匹配器返回的或者是符号failed，或者是给定框架的一个扩充
(define (pattern-match pat dat frame)
    (cond ((eq? frame 'failed) 'failed)
          ((equal? pat dat) frame)
          ((var? pat) (extend-if-consistent pat dat frame))
          ((and (pair? pat) (pair? dat))
           (pattern-match (cdr pat)
                          (cdr pat)
                          (pattern-match (car pat)
                                         (car dat)
                                         frame)))
          (else 'failed)))

; 加入新约束扩充给定的框架，条件是，这一约束与框架中已有的约束相容
(define (extend-if-consistent var dat frame)
    (let ((binding (binding-in-frame var frame)))
        (if binding
            (pattern-match (binding-value binding) dat frame)
            (extend var dat frame))))

; apply以一个模式和一个框架作为输入，生成一个通过应用来自数据库的规则而扩充的框架流
(define (apply-rules pattern frame)
    (stream-flatmap (lambda (rule)
                        (apply-a-rule pattern frame))
                    (fetch-rules pattern frame)))

(define (apply-a-rule rule query-pattern query-frame)
    (let ((clean-rule (rename-variables-in rule)))
        (let ((unify-result
                (unify-match query-pattern
                             (conclusion clean-rule)
                             query-frame)))
            (if (eq? unify-result 'failed)
                the-empty-stream
                (qeval (rule-body clean-rule)
                       (singleton-stream unify-result))))))

; 为每个规则应用关联一个唯一标识
(define (rename-variables-in rule)
    (let ((rule-application-id (new-rule-application-id)))
        (define (tree-walk exp)
            (cond ((var? exp)
                   (make-new-variable exp rule-application))
                  ((pair? exp)
                   (cons (tree-walk (car exp))
                         (tree-walk (cdr exp))))
                  (else exp)))
        (tree-walk rule)))


;合一算法
(define (unify-match p1 p2 frame)
    (cond ((eq? frame 'failed) 'failed)
          ((equal? p1 p2) frame)
          ((var? p1) (extend-if-possible p1 p2 frame))
          ((var? p2) (extend-if-possible p2 p1 frame))
          ((and (pair? p1) (pair? p2))
            (unify-match (cdr p1)
                         (cdr p2)
                         (unify-match (car p1)
                                      (car p2)
                                      frame)))
          (else 'failed)))

(define (extend-if-possible var val frame)
    (let ((binding (binding-in-frame var frame)))
        (cond (binding
                (unify-match
                    (binding-value binding) val frame))
              ((var? val)
               (let ((binding (binding-in-frame val frame)))
                (if binding
                    (unify-match
                    var (binding-value binding) frame)
                    (extend var val frame))))
              ((depends-on? val var frame)
               'failed)
              (else (extend var val frame)))))

; depends-on?检查一个想作为某模式变量的值的表达式是否依赖于这一变量
(define (depends-on? exp var frame)
    (define (tree-walk e)
        (cond ((var? e)
               (if (equal? var e)
                   #t
                   (let ((b (binding-in-frame e frame)))
                       (if b
                           (tree-walk (binding-value b))
                           #f))))
              ((pair? e)
               (or (tree-walk (car e))
                   (tree-walk (cdr e))))
              (else #f)))
    (tree-walk exp))


; 数据库维护
(define THE-ASSERTIONS the-empty-stream)

(define (fetch-assertions pattern frame)
    (if (use-index? pattern)
        (get-indexed-assertions pattern)
        (get-all-assertions)))

(define (get-all-assertions) THE-ASSERTIONS)

(define (get-indexed-assertions pattern)
    (get-stream (index-key-of pattern) 'assertion-stream))

(define (get-stream key1 key2)
    (let ((s (get key1 key2)))
        (if s s the-empty-stream)))

(define THE-RULES the-empty-stream)

(define (fetch-rules pattern frame)
    (if (use-index? pattern)
        (get-indexed-rules pattern)
        (get-all-rules)))

(define (get-all-rules) THE-RULES)

(define (get-indexed-rules pattern)
    (stream-append
        (get-stream (index-key-of pattern) 'rule-stream)
        (get-stream '? 'rule-stream)))

(define (add-rule-or-assertion! assertion)
    (if (rule? assertion)
        (add-rule! assertion)
        (add-assertion! assertion)))

(define (add-assertion! assertion)
    (store-assertion-in-index assertion)
    (let ((old-assertion THE-ASSERTIONS))
          (set! THE-ASSERTIONS
               (cons-stream assertion old-assertions))
          'ok))

(define (add-rule! rule)
    (store-rule-in-index rule)
    (let ((old-rules THE-RULES))
       (set! THE-RULES (cons-stream rule old-rules))
       'ok))

(define (store-assertion-in-index assertion)
    (if (indexable? assertion)
        (let ((key (index-key-of assertion)))
            (let ((current-assertion-stream
                   (get-stream key 'assertion-stream)))
                (put key
                     'assertion
                     (cons-stream assertion
                                  current-assertion-stream))))))

(define (store-rule-in-index rule)
    (let ((pattern (conclusion rule)))
        (if (indexable? pattern)
            (let ((key (index-key-of pattern)))
                (let ((current-rule-stream
                        (get-stream key 'rule-stream)))
                    (put key
                         'rule
                         (cons-stream rule
                                      current-rule-stream)))))))

(define (indexable? pat)
    (or (constant-symbol? (car pat))
        (var? (car pat))))

(define (index-key-of pat)
    (let ((key (car pat)))
        (if (var? key) '? key)))

(define (use-index? pat)
    (constant-symbol? (car pat)))

; 流操作
(define (stream-append-delayed s1 delayed-s2)
    (if (stream-null? s1)
        (force delayed-s2)
        (cons-stream
            (stream-car s1)
            (stream-append-delayed (stream-cdr s1) delayed-s2))))

(define (interleave-delayed s1 delayed-s2)
    (if (stream-null? s1)
        (force delayed-s2)
        (cons-stream
            (stream-car s1)
            (interleave-delayed (force delayed-s2)
                                (delay (stream-cdr s1))))))

(define (stream-flatmap proc s)
    (flatten-stream (stream-map proc s)))

(define (flatten-stream stream)
    (if (stream-null? stream)
        the-empty-stream
        (interleave-stream
            (stream-car stream)
            (delay (flatten-stream (stream-cdr stream))))))

; 只包含一个元素的流
(define (singleton-stream x)
    (cons-stream x the-empty-stream))

; 查询的语法过程
(define (type exp)
    (if (pair? exp)
        (car exp)
        (error "Unknown expression TYPE" exp)))

(define (contents exp)
    (if (pair? exp)
        (cdr exp)
        (error "Unknown expression CONTENTS" exp)))

(define (assertion-to-be-added? exp)
    (eq? (type exp) 'assert!))

(define (add-assertion-body exp)
    (car (contents exp)))

(define (empty-conjunction? exps) (null? exps))
(define (first-conjunct exps) (car exps))
(define (rest-conjuncts exps) (cdr exps))

(define (empty-disjunction? exps) (null? exps))
(define (first-disjunct exps) (car exps))
(define (rest-disjuncts exps) (cdr exps))

(define (negated-query exps) (car exps))

(define (predicate exps) (car exps))
(define (args exps) (cdr exps))

(define (rule? statement)
    (tagged-list? statement 'rule))

(define (conclusion rule) (cadr rule))

(define (rule-body rule)
    (if (null? (cddr rule))
        '(always-true)
        (caddr rule)))

(define (query-syntax-process exp)
    (map-over-symbols expand-question-mark exp))

(define (map-over-symbols proc exp)
    (cond ((pair? exp)
           (cons (map-over-symbols proc (car exp))
                 (map-over-symbols proc (cdr exp))))
          ((symbol? exp) (proc exp))
          (else exp)))

(define (expand-question-mark symbol)
    (let ((chars (symbol->string symbol)))
        (if (string=? (substring chars 0 1) "?")
            (list '?
                  (string->symbol
                   (substring chars 1 (string-legth chars))))
            symbol)))

(define (var? exp)
    (tagged-list? exp '?))

(define (constant-symbol? exp) (symbol? exp))

(define rule-counter 0)

(define (new-rule-application-id)
    (set! rule-counter (+ 1 rule-counter))
    rule-counter)

(define (make-new-variable var rule-application-id)
    (cons '? 9cons rule-application-id (cdr var)))

(define (countract-question-mark variable)
    (string->symbol
        (string-append "?"
            (if (number? (cadr variable))
                (string-append (symbol->string (caddr variable))
                                "-"
                                (number->string (cadr variable)))
                (symbol->string (cadr variable))))))

(define (make-binding variable value)
    (cons variable value))

(define (binding-variable binding)
    (car binding))

(define (binding-value binding)
    (cdr binding))

(define (binding-in-frame variable frame)
    (assoc variable frame))

(define (extend variable value frame)
    (cons (make-binding variable value) frame))