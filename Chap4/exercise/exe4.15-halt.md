## 命题：

> 给定一个单参数过程p和一个对象a，如果对于表达式(p a)的求值可以返回一个值，则称p对a“终止”。
>
> 证明：不存在过程halts?，使它能正确地对任何过程p和对象a判定是否p对a终止。

## 证明：

- 定义下面的两个过程：

```scheme
(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))
```

- 考虑表达式`(try try)`的求值情况：
  - 如果得到`'halted`，说明`(halts? try try)`为`false`，则`try`不能终止，得到了矛盾。
  - 如果永远运行下去，说明`(halts? try try)`为`true`，则`try`可以终止，得到矛盾

从书下的的小字可以知道这就是伟大的`停机定理`，是清晰描述的第一个`不可计算`的问题。

