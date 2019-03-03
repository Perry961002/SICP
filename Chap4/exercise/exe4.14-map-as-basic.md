## 为什么将`map`作为基本过程安装到求值器中不行呢？

- 我们来看一个实际一点的例子:

  ```scheme
  (map + (list 1 2) (list 3 4))
  ```

  因为我们把`map`作为基本过程了，所以将会调用过程`apply-primitive-procedure`，得到的`list-of-values`：

  ```scheme
  (+ (list 1 2) (list 3 4))
  ```

  而这个里面的`+`也是一个基本过程，它在环境中被安装成了：

  ```scheme
  (list 'primitive +)
  ```

  所以刚刚的例子会被处理成：

  ```scheme
  (map (list 'primitive +) (list 1 2) (list 3 4))
  ```

  所以这样的`map`肯定是失败的。



