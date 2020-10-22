# EquationServer
## 项目说明
这部分代码是并联机器人的方程解算模块，用于逆运动学的计算，使用了Github上的一个用C/C++实现的解四次方程的模块[Quartic](https://github.com/sasamil/Quartic)，在此致谢。

## 功能
从调节器接收空间位置信息' X,Y,Z '，通过计算之后返回舵机角度组(六个舵机角度数据)。