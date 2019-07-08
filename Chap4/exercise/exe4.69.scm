; 表的最后一个元素是grandson
(rule (end-is-grandson (grandson)))

(rule (end-is-grandson (?x . ?y))
    (end-is-grandson ?y))

; 定义表(grandson)
(rule ((grandson) ?x ?y)
    (grandson ?x ?y))

; 孙子的儿子是重孙
(rule ((great . ?rel) ?x ?y)
    (and (end-is-grandson ?rel)
         (son ?x ?z)
         (?rel ?z ?y)))