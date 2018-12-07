;Huffman树的表示
;将树叶表示为包含符号leaf、页中符号和权重的表
(define (make-leaf symbol weight)
    (list 'leaf symbol weight))

;判断对象是不是叶子
(define (leaf? object)
    (eq? (car object) 'leaf))

;取得叶中符号
(define (symbol-leaf x) (cadr x))

;取得权重
(define (weight-leaf x) (caddr x))

;Huffman树的构造函数
(define (make-code-tree left right)
    (list left ;左枝
          right ;右枝
          (append (symbol left) (symbol right)) ;符号集
          (+ (weight left) (weight right)))) ;权重

;选择函数
(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbol tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))
;-----------------------------------------------------------
;解码过程
(define (choose-branch bit branch)
    (cond ((= bit 0) (left-branch branch))
          ((= bit 1) (right-branch branch))
          (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (decode bits tree)
    (define (decode-1 bits current-branch) ;以一个二进制表和树中的位置
        (if (null? bits)
            '()
            (let ((next-branch
                    (choose-branch (car bits) current-branch)))
                (if (leaf? next-branch)
                    (cons (symbol-leaf next-branch)
                          (decode-1 (cdr bits) tree))
                    (decode-1 (cdr bits) next-branch)))))
    (decode-1 bits tree))
;----------------------------------------------------------------------
;带权重元素的集合
;将树和树叶的集合表示为一批元素的表，按照权重的上升顺序排列表中的元素
;比较的是元素的权重，而且新加入的元素原来不会出现在集合中
(define (adjoin-set x set)
    (cond ((null? set) (list x))
          ((< (weight x) (weight (car set))) (cons x set))
          (else (cons (car set)
                      (adjoin-set x (cdr set))))))

;以一个符号-权重对偶的表为参数，构造出树叶的初始排序集合
(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair)
                                   (cadr pair))
                        (make-leaf-set (cdr pairs))))))