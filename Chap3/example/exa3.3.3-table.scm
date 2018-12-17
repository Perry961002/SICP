;基本过程

;以一个关键码为参数，返回与之相关联的值
(define (lookup key table)
    (let ((record (assoc key (cdr table))))
        (if record
            (cdr record)
            #f)))

;返回以给定关键码为car的那个记录
(define (assoc key records)
    (cond ((null? records) #f)
          ((equal? key (caar records)) (car records))
          (else (assoc key (cdr records)))))

;在一个表格里某个特定的关键码之下插入一个值，先检查关键码是否已经出现，如果没有就构造新的记录，有的话就修改cdr的值
(define (insert! key value table)
    (let ((record (assoc key (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table
                      (cons (cons key value) (cdr table))))) ;头插法
    'ok)

;创建一个包含符号*table*的表
(define (make-table)
    (list '*table*))
;------------------------------------------------------------------------------------------------------------
;二维表格

;先用第一个关键码确定对应的子表格，而后用第二个关键码在这个子表格里确定记录
(define (lookup key-1 key-2 table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
                (if record
                    (cdr record)
                    #f))
            #f)))

;首先用assoc去查看在第一个关键码下是否存在一个子表格。如果没有，就构造一个新的子表格，其中只包含记录(key-2, value)，并将子表格插入到表格中第一个关键码之下。
;如果表格里已经存在对应于第一个关键码的子表格，那么就将新值插入该子表格。
(define (insert! key-1 key-2 value table)
    (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
                (if record
                    (set-cdr! record value)
                    (set-cdr! subtable
                              (cons (cons key-2 value)
                                    (cdr subtable)))))
            (set-cdr! table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr table)))))
    'ok)
;-----------------------------------------------------------------------------------------------------------------
;创建局部表格
(define (make-table)
    (let ((local-table (list '*table*)))
        (define (assoc key records)
            (cond ((null? records)
                    #f)
                  ((equal? key (caar records)) 
                    (car records))
                  (else
                    (assoc key (cdr records)))))
        (define (lookup key-1 key-2)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (cdr record)
                            #f))
                    #f)))
        (define (insert! key-1 key-2 value)
            (let ((subtable (assoc key-1 (cdr local-table))))
                (if subtable
                    (let ((record (assoc key-2 (cdr subtable))))
                        (if record
                            (set-cdr! record value)
                            (set-cdr! subtable
                                      (cons (cons key-2 value)
                                            (cdr subtable)))))
                    (set-cdr! local-table
                              (cons (list key-1
                                          (cons key-2 value))
                                    (cdr local-table)))))
            'ok)
        (define (dispatch m)
            (cond ((eq? m 'lookup-proc) lookup)
                  ((eq? m 'insert-proc!) insert!)
                  (else 
                    (error "Unknown operation -- TABLE" m))))
        dispatch))
(define operation-table (make-table))

(define get (operation-table 'lookup-proc))

(define put (operation-table 'insert-proc!))