; b)
(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1)))
              (right (right-split painter (- n 1)))
              (corner (corner-split painter (- n 1))))
            (beside (below painter up)
                    (below right corner)))))

; c)
;改为从正方形的每个角向外看
(define (square-limit painter n)
    (let ((combin4 (square-of-four identity flip-horiz
                                   flip-vert rotate180)))
        (combin4 (corner-split painter n))))