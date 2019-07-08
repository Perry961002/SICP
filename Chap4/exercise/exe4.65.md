```scheme
(rule (wheel ?person)
	(and (supervisor ?middle-manager ?person)
       (supervisor ?x ?middle-manager)))
```

- 模拟一下`(wheel ?who)`的应用过程：

  - 执行第一个查询，得到如下的绑定：

    > {?middle-manager : (Aull DeWitt), ?who : (Warbucks Oliver)}
    >
    > {?middle-manager : (Cratchet Robert), ?who : (Scrooge Eben)}
    >
    > {?middle-manager : (Scrooge Eben), ?who : (Warbucks Oliver)}
    >
    > {?middle-manager : (Bitdiddle Ben), ?who : (Warbucks Oliver)}
    >
    > {?middle-manager : (Reasoner Louis), ?who : (Hacker Alyssa P)}
    >
    > {?middle-manager : (Tweakit Lem E), ?who : (Bitdiddle Ben)}
    >
    > {?middle-manager : (Fect Cy D), ?who : (Bitdiddle Ben)}
    >
    > {?middle-manager : (Hacker Alyssa P), ?who : (Bitdiddle Ben)}

  - 接下来执行and的第二部分，得到一个新的框架：

    > {{?x : (Cratchet Robert), ?middle-manager : (Scrooge Eben)], ?who : (Warbucks Oliver)}
    >
    > {{?x : (Tweakit Lem E), ?middle-manager : (Bitdiddle Ben)}, ?who : (Warbucks Oliver)}
    >
    > {{?x : (Fect Cy D), ?middle-manager : (Bitdiddle Ben)}, ?who : (Warbucks Oliver)}
    >
    > {{?x : (Hacker Alyssa P), ?middle-manager : (Bitdiddle Ben)}, ?who : (Warbucks Oliver)}
    >
    > {{?x : (Reasoner Louis), ?middle-manager : (Hacker Alyssa P)}, ?who : (Bitdiddle Ben)}

所以`Warbucks Oliver`出现了4次。