; (x)的反转也是(x)
(rule (reverse (?x) (?x)))

; (x . y)的反转是(y)反转的结果和(x)做append的结果
(rule (reverse (?x . ?y) ?z)
    (and (reverse ?y ?reversed-y)
         (append-to-form ?reversed-y (?x) ?z)))