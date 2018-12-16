- 给出题目的代码
```
(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))

(define p3 (cons 3 '()))
(define p2 (cons 2 p3))
(define p1 (cons 1 p2))
(count-pairs p1) ; ==> 3

(define q3 (cons 'b '()))
(define q2 (cons 'a q3))
(define q1 (cons q2 q3))
(count-pairs q1) ; ==> 4

(define r3 (cons 'r '()))
(define r2 (cons r3 r3))
(define r1 (cons r2 r2))
(count-pairs r1) ; ==> 7

(define w3 (cons '() '()))
(define w2 (cons 'w w3))
(define w1 (cons w2 '()))
(set-car! w3 w1)
(count-pairs w1) ; ==> 死循环
```
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.16-cons/a.jpg" alt="a"/>
</p>