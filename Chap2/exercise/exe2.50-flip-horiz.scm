(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                                (sub-vect (m corner1) new-origin)
                                (sub-vect (m corner2) new-origin)))))))

;水平上反转画家
(define (flip-horiz painter)
    (transform-painter painter
                       (make-vect 1 0)
                       (make-vect 0 0)
                       (make-vect 1 1)))

;逆时针方向旋转180
(define (rotate180 painter)
    (transform-painter painter
                       (make-vect 1 1)
                       (make-vect 0 1)
                       (make-vect 1 0)))

;逆时针旋转270
(define (rotate270 painter)
    (transform-painter painter
                       (make-vect 0 1)
                       (make-vect 0 0)
                       (make-vect 1 1)))