(define (analyze-let exp)
  (analyze (let->combination exp)))