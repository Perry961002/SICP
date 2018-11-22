(define (filtered-accumulate combiner null-value filter term a next b)
    (cond ((> a b) null-value)
          ((filter a) (combiner (term a)
                                (accumulate combiner 
                                            null-value 
                                            filter 
                                            term 
                                            (next a) 
                                            next 
                                            b)))
           (else (accumulate combiner 
                             null-value 
                             filter 
                             term 
                             (next a)
                             next
                             b))))