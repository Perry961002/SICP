;定义过程split, 第一个参数表示向哪个方向做分割和分支, 第二个参数表示两个分支之间的组合方式
(define (split big small)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split big small) painter (- n 1))))
                (big painter
                     (small smaller smaller))))))