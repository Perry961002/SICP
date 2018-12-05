(load "Chap2\\example\\exa2.3.1-quotation.scm")

(list 'a 'b 'c) ;==> (a b c)

(list (list 'george)) ;==> ((george))

(cdr '((x1 x2) (y1 y2))) ;==> ((y1 y2))

(cadr '((x1 x2) (y1 y2))) ;==> (y1 y2)

(pair? (car '(a short list))) ;==> #f

(memg 'red '((red shoes) (blue socks))) ;==> #f

(memg 'red '(red shoes blue socks)) ; ==> (red shoes blue socks)