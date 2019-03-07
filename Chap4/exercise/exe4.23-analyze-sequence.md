- Alyssa给出的过程

  ```scheme
  (define (analyze-sequence exps)
    (define (execute-sequence procs env)
      (cond ((null? (cdr procs)) ((car procs) env))
            (else ((car procs) env)
                  (execute-sequence (cdr procs) env))))
    (let ((procs (map analyze exps)))
      (if (null? procs)
          (error "Empty sequence -- ANALYZE"))
      (lambda (env) (execute-sequence procs env))))
  ```

  Eva给出的解释：

  > 正文给出的版本在分析阶段完成了序列求值中更多的工作。Alyssa的序列求值过程并没有去调用内部建立的各个求值过程，而是循环地通过一个过程去调用它们。从效果上看，虽然序列中各个表达式都经过了分析，但整个序列本身却没有分析。

- 其实上面的解释也挺难理解的，说点我的理解

  > 观察Alyssa的过程可以发现最后返回的是(lambda (env) (execute-sequence procs env))，这种情况下真正分析各个表达式的过程其实是在环境中完成的。
  >
  > 而正文中的代码是要等(loop (car procs) (cdr procs))求值完之后才返回，因此它完成了对整个序列本身的分析。