# python脚本工作环境

## 初始化

1. 先写一个python脚本

   test.py 权限是又执行的

   Test2.py 权限是没有执行的

test.py

```python
#! /usr/bin/python
# -*- coding: utf-8 -*-

print('Your first python script')
```

Test2.py

```python
#! /usr/bin/python
# -*- coding: utf-8 -*-
print('My second script')
a = 12
b = 24
print(a+b)
```



2. 在terminal执行

```shell
litingdeMacBook-Pro:~ liting$ cd ml
litingdeMacBook-Pro:ml liting$ ls -l
total 8
-rwxr-xr-x@ 1 liting  staff  77  8 22 14:39 test.py
litingdeMacBook-Pro:ml liting$ ls -l
total 16
-rwxr-xr-x@ 1 liting  staff  77  8 22 14:39 test.py
-rw-r--r--@ 1 liting  staff  92  8 22 14:46 test2.py
litingdeMacBook-Pro:ml liting$ ./test.py
Your first python script
litingdeMacBook-Pro:ml liting$ ./test2.py
-bash: ./test2.py: Permission denied
litingdeMacBook-Pro:ml liting$ chmod a+x test2.py
litingdeMacBook-Pro:ml liting$ ./test2.py
My second script
36

```

总结下：

定义一个python脚本，开头指定python和编码方式

给这个脚本执行的权限

执行

