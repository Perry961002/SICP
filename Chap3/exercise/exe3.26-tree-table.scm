;构造函数
(define (make-tree key value left right)
    (list (cons key value) left right))

;选择函数
(define (entry tree) (car tree))

(define (tree-key tree) (car (entry tree)))

(define (tree-vale tree) (cadr (entry tree)))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

;判空
(define (empty-tree? tree) (null? tree))

;修改函数
(define (set-key! new-key tree)
    (set-car! (entry tree) new-key))

(define (set-value! new-value tree)
    (set-cdr! (entry tree) new-value))

(define (set-left-branch! new-left-branch tree)
    (set-car! (cdr tree) new-left-branch))

(define (set-right-branch! new-right-branch tree)
    (set-car! (cddr tree) new-right-branch))

;查找函数
;按照给定的key和比较函数compare查找
(define (tree-lookup key tree compare)
    (if (empty-tree? tree)
        #f
        (let ((result (compare key (tree-key tree))))
            (cond ((= result 0)
                   (entry tree))
                  ((= result -1)
                   (tree-lookup key (left-branch tree) compare))
                  ((= result 1)
                   (tree-lookup key (right-branch tree) compare))))))

;插入函数
;按照给定的key和比较函数compare插入
(define (tree-insert! key value tree compare)
    (if (empty-tree? tree)
        (make-tree key value '() '())
        (let ((result (compare key (tree-key tree))))
            (cond ((= result 0)
                   (set-value! value tree)
                   tree)
                  ((= result -1)
                   (set-left-branch!
                        (tree-insert! key value (left-branch tree) compare)
                        tree)
                    tree)
                  ((= result 1)
                   (set-right-branch!
                        (tree-insert! key value (right-branch tree) compare)
                        tree)
                    tree)))))

;用tree实现表格，基于比较函数
(define (make-table compare)
    (let ((table (list '*table*)))
        (define (empty?)
            (empty-tree? (cdr table)))

        (define (insert! key value)
            (set-cdr! table
                      (tree-insert! key value (cdr table) compare))
            table)

        (define (lookup key)
            (tree-lookup key (cdr table) compare))

        (define (dispatch m)
            (cond ((eq? m 'empty?) (empty?))
                  ((eq? m 'insert!) insert!)
                  ((eq? m 'lookup) lookup)
                  ((eq? m 'print-table) table)
                  (else
                    (error "Unknown operation -- TABLE" m))))
        dispatch))

;测试：

;整数序的比较排序
(define (compare-number x y)
    (cond ((= x y) 0)
          ((< x y) -1)
          (else 1)))

(define t (make-table compare-number))

((t 'insert!) 4 'd)
((t 'insert!) 2 'b)
((t 'insert!) 1 'a)
((t 'insert!) 3 'c)
((t 'insert!) 6 'f)
((t 'insert!) 5 'e)
((t 'insert!) 7 'g)

(display (t 'print-table))