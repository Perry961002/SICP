```scheme
;Cy 给出的版本
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (actual-value (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))

;正文给出的版本
(define (eval-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (else (eval (first-exp exps) env)
              (eval-sequence (rest-exps exps) env))))
```

## a )

- Ben举的例子

  ```scheme
  (define (for-each proc items)
    (if (null? items)
      'done
      (begin (proc (car items))
             (for-each proc (cdr items)))))
  
  (for-each (lambda (x) (newline) (display x))
            (list 5 6 7 8))
  ```

  之所以正确，是因为`for-each`中不需要关心的`proc`的返回值。

## b )

- Cy举的代码

  ```scheme
  (define (p1 x)
    (set! x (cons x '(2))))
  
  (define (p2 x)
    (define (p e)
      e
      x)
    (p (set! x (cons x '(2)))))
  ```

- 按正文的代码：`(p1 1) ==> (1 . 2)`      `(p2 1) ==> 1`

- 按Cy的代码：`(p1 1) ==> (1 . 2)`    `(p2 1) ==> (1 . 2)`

## c )

- 因为Cy 版本的代码只是加强了强迫求值，会去求传入`eval-sequence`中每一个表达式的值而已。

## d )

- 个人觉得Cy的版本更好，因为它可以避免 `b)` 里面发生的情况，而且可以兼容 `a)` 里面的情况。