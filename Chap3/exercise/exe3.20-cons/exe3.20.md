```
(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
```
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.20-cons/a.jpg" alt="a"/>
</p>

```
(car x)
```
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.20-cons/b.jpg" alt="b"/>
</p>