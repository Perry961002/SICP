```scheme
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person ?middle-manager))))
```

- 因为当系统查询`(outranked-by ?middle-manager ?boss)`时，`?middle-manager`可能会被求值为`?staff-person`，造成了递归调用。

