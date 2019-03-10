- 总结一下条件：

  |   父亲   |   游艇    |
  | :------: | :-------: |
  | Barnacle | Gabrielle |
  |  Moore   |   Lorna   |
  |   Hall   | Rosalind  |
  | Downing  |  Melissa  |
  |  Parker  |     ?     |

  |   父亲   |  女儿   |
  | :------: | :-----: |
  | Barnacle | Melissa |
  |  Moore   |  Moore  |

  还有一个条件就是：`Gabrielle.父亲.游艇 = Parker.女儿`

- 我的代码：

  ```scheme
  (define (father-daughter) 
     (let ((Moore 'Mary) 
           (Barnacle 'Melissa) 
           (Hall (amb 'Gabrielle 'Lorna)) 
           (Downing (amb 'Gabrielle 'Lorna 'Rosalind)) 
           (Parker (amb 'Lorna 'Rosalind))) 
       (require (cond ((eq? Hall 'Gabrielle) (eq? 'Rosalind Parker)) 
                      ((eq? Downing 'Gabrielle) (eq? 'Melissa Parker)) 
                      (else false))) 
       (require (distinct? (list Hall Downing Parker))) 
       (list (list 'Barnacle Barnacle) 
             (list 'Moore Moore) 
             (list 'Hall Hall) 
             (list 'Downing Downing) 
             (list 'Parker Parker)))) 
  ```

  

