; a)
(and (superisor ?name (Bitdiddle Ben))
     (address ?name ?address))

; b)
(and (salary (Bitdiddle Ben) ?ben-salary)
     (salary ?name ?salary)
     (lisp-value < ?salary ?ben-salary))

; c)
(and (not (job ?name (computer . ?type)))
     (superisor ?name ?superisor)
     (job ?name ?job))