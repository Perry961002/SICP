;多维情况的表格表示

(define (make-table)
    (list '*table*))

(define (assoc key records)
    (cond ((null? records) #f)
          ((not (pair? records)) #f)
          ((equal? key (caar records)) (car records))
          (else (assoc key (cdr records)))))

(define (lookup key-list table)
    (let ((first-key (car key-list))
          (remain-key (cdr key-list)))
        (let ((record (assoc first-key (cdr table))))
            (if record
                (if (null? remain-key)
                    (cdr record)
                    (lookup remain-key record))
                #f))))

;将记录插入表格
(define (adjoin-table new-record table)
    (set-cdr! table
              (cons new-record (cdr table))))

(define (insert! key-list value table)
    (let ((first-key (car key-list))
          (remain-key (cdr key-list)))
        (let ((record (assoc first-key (cdr table))))
            (cond
                ; 1) record存在，remain-key为空
                ((and record (null? remain-key))
                 (set-cdr! record value)
                 table)
                ; 2) record存在，remain-key存在
                ((and record remain-key)
                 (insert! remain-key value record)
                 table)
                ; 3) record不存在，remain存在
                ((and (not record) (not (null? remain-key)))
                 (adjoin-table (insert! remain-key value (list first-key)) table)
                 table)
                ; 4) 都不存在
                (else
                    (let ((new-record (cons first-key value)))
                        (adjoin-table new-record table)
                        table))
                ))))

;测试用例
;(define t (make-table))
;(insert! '(b) 2 t) ; case 1, ==> (*table* (b . 2))
;(insert! '(b c) 3 t) ; case 2, ==> (*table* (b (c . 3) . 2))
;(insert! '(a b) 1 t) ; case 3, ==> (*table* (a (b . 1)) (b (c . 3) . 2))
;(insert! '(d) 4 t) ; case 4, ==> (*table* (d . 4) (a (b . 1)) (b (c . 3) . 2))