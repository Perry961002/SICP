- 因为没有保证`test-and-set!`这一操作原子化，所以`P1`和`P2`可以`同时`对互斥元进行设置，最后， `P1`和`P2`都获取了互斥元
<p align="center">
  <img src="https://github.com/Perry961002/Learning-notes-of-SICP/blob/master/Chap3/exercise/exe3.46-test-and-set!/a.jpg" alt="a"/>
</p>