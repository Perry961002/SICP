(rule (grandson ?g ?s)
    (and (son ?f ?s)
         (son ?g ?f)))

(rule (also-son ?m ?s)
    (or (son ?m ?s)
        (and (wife ?w ?m)
             (son ?w ?s))))