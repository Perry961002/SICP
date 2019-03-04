## a)

- 我们将题目里有关阶乘的案例的代码分离出有用的部分

  ```scheme
  (lambda (n)
    ((lambda (fact) (fact fact n))   ;称为l1
     (lambda (ft k)             ;称为l2
       (if (= k 1)
           1
           (* k (ft ft (- k 1)))))
     )
    )
  ```

  我们可以看到阶乘的核心步骤就是`l1`和`l2`组成复合过程，其中`l1`接收`l2`进行求值即`(l2 l2 n)`。因此我们进行一下转换得到

  ```scheme
  (if (= n 1)
      1
      (* n (l2 l2 (- k 1))))
  ```

  明显的，我们在上面看到了递归的形式，因此这个过程是可以求出`n`的阶乘的。

- 有了上面的分析，可以类比的写出斐波那契数的表达式

  ```scheme
  ;a = Fib(1) = 1, b = Fib(0) = 0
  ;变换规则：a := a + b, b := a
  (lambda (n)
    ((lambda (fib) (fib fib 1 0 n))
     (lambda (fb a b count)
       (if (= count 0)
           b
           (fb fb (+ a b) a (- count 1))))))
  ```

## b)

我们在例子里看到了包含相互递归的内部定义，假设`a,` `b`相互递归，那么`a`中调用`b`时参数类型必须和`b`的形参一致，同样的，`b`中调用`a`时参数类型必须和`a`的形参一致。有点交错的感觉。

```scheme
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)  ;l1
     (if (= n 0)
         #t
         (od? <??> <??> <??>)))  ;h1
   (lambda (ev? od? n)  ;l2
     (if (= n 0)
         #f
         (ev? <??> <??> <??>))))) ;h2
```

- 将`l1`、`l2`带入求值，得到

  ```
  (l1 l1 l2 x)
  ```

  根据`l1`展开，得到

  ```
  (l2 <??> <??> <??>)
  ```

  结合`l2`的形参，所以，这里的`h1`处三个分别是`ev?`、`od?`、`(- n 1)`。

  `h2`处同样也是`ev?`、`od?`、`(- n 1)`。

