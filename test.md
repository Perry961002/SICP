```scheme
;将两个序对交替取出
; s1,t1,s2,t2,...,si,ti,...
(define (interleave s t)
    (if (stream-empty? s)
        t
        (stream-cons (stream-car s)
                     (interleave t (stream-cdr s)))))
;序对流
(define (pairs s t)
    (stream-cons
        (list (stream-car s) (stream-car t))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) x))
                        (stream-cdr t))
            (pairs (stream-cdr s) (stream-cdr t)))))

;(display-top10 (pairs integers integers))
;(1 1)  (1 2)  (2 2)  (1 3)  (2 3)  (1 4)  (3 3)  (1 5)  (2 4) 
```
- 以$Pa(S, T)$表示序对$(S_i, T_j)$组成的流，其中$(i \le j\  且\ i, j > 0)$。对这个流有如下描述：

  ​	流的第一个序对是 $(S_1, T_1)$，其他部分是流$ \begin{Bmatrix}(S_1, T_2), (S_1, T_3), \cdots\end{Bmatrix} $和 $Pa(S.r, T.r) $中的序对元素按交叉顺序出现的流。(其中$S.r$表示流$S$中第一个元素之外的其他元素，用 $\langle a, b \rangle$ 表示流 $a,\ b$ 中的元素按交叉顺序出现)，则有
  $$
  Pa(S, T) = \begin{Bmatrix}(S_1, T_1), \langle\ \begin{Bmatrix}(S_1, T_2), (S_1, T_3), \cdots\end{Bmatrix}，Pa(S.r, T.r)\  \rangle \end{Bmatrix}
  $$




- 用 $F(i, j)$ 表示序对$ (S_i, T_j)$ 到序对$ (S_1, T_1)$ 的距离，结合上面的描述，我们递归的给出这个函数表达式：

  ​	假设分别从 $S $和 $T$ 的第 $i-1 $和 $j-1 $的位置开始构造，可以得到下面的一个流(为了方便，这里仅用下标表示元素)：
  $$
  \cdots, (i-1, j-1), (i-1, j), (i, j), (i-1, j+1), \cdots
  $$
  ​	我们知道序对$ (i-1, j-1) $到首序对的距离为 $F(i-1, j-1)$，结合$Pa(S, T)$的数学描述，明显的我们可以得到
  $$
  F(i ,j) = 2 * F(i-1, j-1) + 2
  $$
  特殊的，我们知道 $F(1, 1) = 0，F(1, j) = 2 * j - 3，(j > 1)$。
  ​	

  ​	一般的，当 $ i = j$ 时，有
  $$
  F(i ,j) &=& 2 * F(i-1, j-1) + 2\\
  &\vdots&\\
  \         &=& 2^{(i-1)}*F(1, 1) + 2 + 2^2 + ... + 2^{(i-1)}\\
  &=& 2^i - 2\\
  $$


    ​	当 $ i < j$ 时，我们可以知道 $ i $ 一定会先被减到 $1$ ，所以我们可以得到

$$

\begin{eqnarray*}
  F(i ,j) &=& 2^{(i-1)}*F(1, j-i+1) + 2 + 2^2 + ... + 2^{(i-1)}\\
  &\vdots&\\
  &=& 2^i * (j-i) + 2^{(i-1)}-2
  \end{eqnarray*}

$$

- 按照上面的$F(1, 100) = 197​$，并且代码验证 `(stream-ref (pairs integers integers) 197)`，得到`(1, 100)`

- 那么$F(100, 100) = 2^{100} - 2$