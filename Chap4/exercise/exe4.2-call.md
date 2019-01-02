- a)

  ```
  按照Louis的计划，(define x 3)将会被按照过程应用处理，而不是定义处理。
  ```

- b)

  - 因为过程应用都要以`call`开始，所以需要对`application?`和两个选择函数`operator`、`operands`重写。

    ```
    (define (application? exp) (tagged-list? exp 'call))
    
    (define (operator exp) (cadr ops))
    
    (define (operands exp) (cddr ops))
    ```
