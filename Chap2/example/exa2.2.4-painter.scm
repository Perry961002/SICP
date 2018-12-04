;图形语言：

;beside将第一个画家放在左边, 第二个放在右边
;below上下组合两个画家，第一个画家放在下边, 第二个放在上边
;flip-vert将画家上下颠倒
;flip-horiz将画家左右反转
;一个事实:画家在有关语言的组合方式下是封闭的

(define (flipped-pairs painter)
    (let ((painter2 (beside painter (flip-vert painter))))
        (below painter2 painter2)))

;在图形的右边做分割和分支
(define (right-split painter n)
    (if (= n 0)
        painter
        (let ((smaller (right-split painter (- n 1))))
            (beside painter (below smaller smaller)))))

;同时在图形中向上和向右分支
(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1)))
              (right (right-split painter (- n 1))))
            (let ((top-left (beside up up))
                  (bottom-right (below right right))
                  (corner (corner-split painter (- n 1))))
                (beside (below painter top-left)
                        (below bottom-right corner))))))

;将某个corner-split的4个拷贝适当组合起来
(define (square-limit painter n)
    (let ((quarter (corner-split painter n)))
        (let ((half (beside (flip-horiz quarter) quarter)))
            (below (flip-vert half) half))))
;----------------------------------------------------------------------
;高阶操作:

;基于4个单参数的画家操作, 得到一个画家操作, tl、tr、bl、br应用于4个角的拷贝变换
(define (square-of-four tl tr bl br)
    (lambda (painter)
        (let ((top (beside (tl painter) (tr painter)))
              (bottom (beside (bl painter) (br painter))))
            (below bottom top))))
;--------------------------------------------------------------------------
;框架

;用单位正方形里的坐标去描述图像,对于每一个框架,我们要为他关联一个框架坐标映射,借助它完成图形的位移和伸缩
;映射的功能就是把单位正方形变换到相应的框架,采用的方法就是将向量v = (x, y)映射到向量和：
; Origin(Frame) + x.Edge1(Frame) + y.Edge2(Frame)

;应用于一个框架返回一个过程, 他对于给定的向量返回另一个向量
(define (frame-coord-map frame)
    (lambda (v)
        (add-vect
            (origin-frame frame)
            (add-vect (scale-vect (xcor-vect v)
                                  (edge1-frame frame))
                      (scale-vect (ycor-vect v)
                                  (edge2-frame frame))))))
;--------------------------------------------------------------------------------
;画家
;任何一个过程只要能选取一个框架作为参数, 画出某些伸缩后适合这个框架的东西, 他就可以作为一个画家

;创建一个画家, 对于表中的每一个线段, 这个画家将根据框架坐标映射, 对线段的各个线段做变换, 而后在两个端点画一条线
(define (segment->painter segment-list)
    (lambda (frame)
        (for-each
            (lambda (segment)
                (draw-line
                    ((frame-coord-map frame) (start-segment segment))
                    ((frame-coord-map frame) (end-segment segment))))
            segment-list)))
;---------------------------------------------------------------------------------
;画家的变换和组合

;以一个画家以及有关怎么变换框架和生成画家的信息为参数
;在用作框架变换时，第一个参数描述的是新框架的原点, 另外两个描述的是新框架的两个边向量的终点
(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                                (sub-vect (m corner1) new-origin)
                                (sub-vect (m corner2) new-origin)))))))

;给出颠倒画家的定义
(define (flip-vert painter)
    (transform-painter painter
                       (make-vect 0 1)
                       (make-vect 1 1)
                       (make-vect 0 0)))

;将自己的图形缩到给定框架右上的四分之一的区域
(define (shrink-to-upper-right painter)
    (transform-painter painter
                       (make-vect 0.5 0.5)
                       (make-vect 1.0 0.5)
                       (make-vect 0.5 1.0)))

;将图形按照逆时针方向旋转90度
(define (rotate90 painter)
    (transform-painter painter
                       (make-vect 1.0 0.0)
                       (make-vect 1.0 1.0)
                       (make-vect 0.0 0.0)))

;以两个画家为参数，分别将他们变换为在参数框架的左半边和右半边画图
(define (beside painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let ((paint-left
                (transform-painter painter1 
                                   (make-vect 0.0 0.0)
                                   split-point
                                   (make-vect 0.0 1.0)))
              (paint-right
                (transform-painter painter2
                                   split-point
                                   (make-vect 1.0 0.0)
                                   (make-vect 0.5 1.0))))
            (lambda (frame)
                (paint-left frame)
                (paint-right frame)))))