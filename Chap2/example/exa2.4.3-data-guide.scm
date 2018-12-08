;数据导向的程序设计(基于类型的分派，可加性)
;采用一集过程作为复数算数和两个表示包之间的界面，并让这些过程中的每一个去做基于类型的显式分派
;将这一界面作为一个过程，由他用操作名和参数类型的组合到表格中查找，以便找到适当的过程
;假定有两个过程put和get，用于处理这种 操作-类型 表格
;(put <op><type><item>), 将项<item>加入表格中，以<op>和<type>作为表项的索引

;(get <op><type>), 在表中查找与<op>和<type>对应的项，如果找到就返回找到的项，否则就返回假

;定义直角坐标下的程序包
(define (install-rectangular-package)
    ;internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
        (sqrt (+ (square (real-part z))
                 (square (imag-part z)))))
    (define (angle z)
        (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
        (cons (* r (cos a)) (* r (sin a))))
    ;interface to the rest of the systeam
    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

;定义极坐标包
(define (install-polar-package)
    ;internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang) (cons r a))
    (define (real-part z)
        (* (magnitude z) (cos (angle z))))
    (define (imag-part z)
        (* (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
              (atan y x)))
    ;interface to the rest of the systeam
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
        (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
        (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

;过程apply-generic在表格中用操作名和参数类型查找，如果找到，就去应用查找得到的过程
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error
                    "No method for these types -- APPLY-GENERIC"
                    (list op type-tags))))))

;定义各种通用型选择函数
(define (real-part z) (apply-generic 'real-part z))

(define (imag-part z) (apply-generic 'imag-part z))

(define (magnitude z) (apply-generic 'magnitude z))

(define (angle z) (apply-generic 'angle z))
;如果要将一个新表示形式加入这个系统，上述这些都完全不必修改

;从表中提取出构造函数，用到包之外的程序
(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))

(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))