- 首先说一下为什么不能用`(an-integer-starting-from n)`

  > 我们知道(an-integer-starting-from n)返回任何一个大于或者等于n的整数，也就是说如果没有一个终止条件的话它将一直产生>=n的整数。
  >
  > 另外我们知道amb求值器使用的是**深度搜索**的策略，它的一个特点是：如果在任何选择点用完了所有的可能性，求值器将回退到前一个选择点。
  >
  > 但当发现一个满足条件的k后k依然会一直增加下去，这之后永远不会满足条件，造成了内存溢出。

- k在`满足条件之后一直增长`造成了失败，很重要的原因就是`k放在了最后一个去选择`，如果k在第一个去确定呢？

  我们可以`先定出一个可能的k`，然后选出任何满足`1<=i<=j<=k`的`i`和`j`进行判断即可，这里的两个数都是`有限个数`的，所有判断结束之后k也将继续增长，这个过程显然是对的。

  ```scheme
  (define (pythagorean-triple)
    (let ((k (an-integer-starting-from 1)))
      (let ((i (an-integer-between 1 k)))
        (let ((j (an-integer-between i k)))
          (require (= (+ (* i i) (* j j))
                      (* k k)))
          (list i j k)))))
  ```

  