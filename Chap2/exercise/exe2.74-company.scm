; a)

;设立id作为一个员工在整个体系的唯一标识
;每个分公司实现get-record过程，并且put进总公司
; (define (get-record branch id)
;    ((get 'get-record branch) id))

; b)
;设立数据项salary，实现过程get-salary

; c)

;(define (find-employee-record branch-list id)
;    (if (null? branch-list)
;        (error "Not find" id)
;       (let ((record (get-record (car branch-list) id)))
;            (if (null? record)
;                record
;                (find-employee-record (cdr branch-list) id)))))

; d)

;只需要新增的机构实现相应的get-recorde、get-salary方法即可