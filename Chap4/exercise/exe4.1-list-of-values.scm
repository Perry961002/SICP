;从左到右求值
(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (let ((first (eval (first-operand exps) env)))
            (let ((rest (eval (rest-operands exps) env)))
                (cons first rest)))))

;从右到左
(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (let ((rest (eval (rest-operands exps) env)))
            (let ((first (eval (first-operand exps) env)))
                (cons first rest)))))