; a)
(meeting ?department (Friday ?time))

; b)
(rule (meeting-time ?person ?day-and-time)
    (and (job ?person (?department . ?type))
         (or (meeting ?department ?day-and-time)
             (meeting whole-company ?day-and-time))))

; c)
(meeting-time (Hacker Alyssa P) (Wednesday . ?time))