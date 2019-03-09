- 对比一下两个过程

  ```scheme
  ;练习4.35的
  (define (a-pythagorean-triple-between low high)
      (let ((i (an-integer-between low high)))
          (let ((j (an-integer-between i high)))
              (let ((k (an-integer-between j high)))
                  (require (= (+ (* i i) (* j j)) (* k k)))
                  (list i j k)))))
  
  ;本题的
  (define (a-pythagorean-triple-between low high)
    (let ((i (an-integer-between low high))
          (hsq (* high high)))
      (let ((j (an-integer-between i high)))
        (let ((ksq (+ (* i i) (* j j))))
          (require (>= hsq ksq))
          (let ((k (sqrt ksq)))
            (require (integer? k))
            (list i j k))))))
  ```

  - 第一个的搜索空间是`I`、`J`和`K`的笛卡尔积，`K`属于`J`属于`I`。
  - 第一个的搜索空间是`I`和`J`的笛卡尔积，`J`属于`I`。

