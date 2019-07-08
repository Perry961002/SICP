`这个规则表示如果x和y按顺序出现在列表的前两个位置，则它们是相邻的`

```scheme
(rule (?x next-to ?y in (?x ?y . ?u)))
```

`这个规则表示如果x和y在列表的cdr部分相邻，则它们也是相邻的`

```scheme
(rule (?x next-to ?y in (?y . ?z))
      (? x next-to ?y in ?z))
```



- `(?x next-to ?y in (1 (2 3) 4))`

  > (1 next-to (2 3))
  >
  > ((2 3) next-to 4)

- `(?x next-to 1 in (2 1 3 1))`

  > (2 next-to 1)
  >
  > (3 next-to 1)

