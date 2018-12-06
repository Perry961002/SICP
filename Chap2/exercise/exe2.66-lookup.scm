(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (lookup given-key records)
    (cond ((null? records) #f)
          ((= given-key (entry records)) #t)
          ((< given-key (entry records))
           (lookup given-key (left-branch records)))
          ((> given-key (entry records))
           (lookup given-key (right-branch records)))))