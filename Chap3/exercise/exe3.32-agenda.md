- 首先如果一个事件`a`比另一个事件`b`先发生，自然应该`a`先被执行，所以要用`先进先出`原则的队列来实现。

- 考虑一个与门的行为，题目的两个假设将产生相同的结果，只是中间的状态不同：
    - 如果模拟器使用先进先出的方式处理事件，当输入从 0,1 改变到 1,0 时， a1 的事件先被触发，它取出 a1 和 a2 的值 1,1 ，并将 output 的值设置为 1 ；接着， a2 的事件被触发，它取出 a1 和 a2 的值 1,0 ，并将 output 的值设置为 0 。

    - 如果模拟器使用后进先出的方式处理事件，当输入从 0,1 改变到 1,0 时， a2 的事件先被处理，它取出 a1 和 a2 的值 0,0 ，并将 output 设置为 0 ；接着， a1 的事件被触发，它取出 a1 和 a2 的值 1,0 ，并将 output 的值设置为 0 。