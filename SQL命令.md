# SQL 面试学习

## 语句

SQL语句中常用关键词及其解释如下：

### **1）SELECT**

将资料从数据库中的表格内选出，两个关键字：从 (FROM) 数据库中的表格内选出 (SELECT)。语法为
SELECT "栏位名" FROM "表格名"。

### **2）DISTINCT**

在上述 SELECT 关键词后加上一个 DISTINCT 就可以去除选择出来的栏位中的重复，从而完成求得这个表格/栏位内有哪些不同的值的功能。语法为
SELECT DISTINCT "栏位名" FROM "表格名"。

### **3）WHERE**

这个关键词可以帮助我们选择性地抓资料，而不是全取出来。语法为
SELECT "栏位名" FROM "表格名" WHERE "条件" 

### **4）AND OR**

上例中的 WHERE 指令可以被用来由表格中有条件地选取资料。这个条件可能是简单的 (像上一页的例子)，也可能是复杂的。复杂条件是由二或多个简单条件透过 AND 或是 OR 的连接而成。语法为：
SELECT "栏位名"  FROM "表格名"  WHERE "简单条件"  {[AND|OR] "简单条件"}+

### **5）IN**

在 SQL 中，在两个情况下会用到 IN  这个指令；这一页将介绍其中之一：与 WHERE 有关的那一个情况。在这个用法下，我们事先已知道至少一个我们需要的值，而我们将这些知道的值都放入 IN  这个子句。语法为：
SELECT "栏位名"  FROM "表格名"  WHERE "栏位名" IN ('值一', '值二', ...)  

### **6）BETWEEN**

IN 这个指令可以让我们依照一或数个不连续 (discrete)的值的限制之内抓出资料库中的值，而 BETWEEN 则是让我们可以运用一个范围 (range)  内抓出资料库中的值，语法为：
SELECT "栏位名"  FROM "表格名" WHERE "栏位名" BETWEEN '值一' AND '值二' 

### **7）LIKE**

LIKE 是另一个在 WHERE  子句中会用到的指令。基本上， LIKE  能让我们依据一个模式(pattern) 来找出我们要的资料。语法为：
SELECT "栏位名"  FROM "表格名"  WHERE "栏位名" LIKE {模式} 

### **8）ORDER BY**

我们经常需要能够将抓出的资料做一个有系统的显示。这可能是由小往大 (ascending)  或是由大往小(descending)。在这种情况下，我们就可以运用 ORDER BY 这个指令来达到我们的目的。语法为：
SELECT "栏位名"  FROM "表格名 [WHERE "条件"] ORDER BY "栏位名" [ASC, DESC] 

### **9）函数**

函数允许我们能够对这些数字的型态存在的行或者列做运算，包括 AVG (平均)、COUNT (计数)、MAX (最大值)、MIN (最小值)、SUM (总合)。语法为：
SELECT "函数名"("栏位名") FROM "表格名"  

### 10）COUNT**

这个关键词能够帮我我们统计有多少笔资料被选出来，语法为：
SELECT COUNT("栏位名") FROM "表格名"

### 11）GROUP BY**

GROUP BY 语句用于结合合计函数，根据一个或多个列对结果集进行分组。语法为：
SELECT "栏位1", SUM("栏位2")  FROM "表格名"  GROUP BY "栏位1" 

### 12）HAVING**

该关键词可以帮助我们对函数产生的值来设定条件。语法为：
SELECT "栏位1", SUM("栏位2")  FROM "表格名"  GROUP BY "栏位1"  HAVING (函数条件)  

### 13）ALIAS**

我们可以通过ALIAS为列名称和表名称指定别名，语法为：
SELECT "表格别名"."栏位1" "栏位别名"  FROM "表格名" "表格别名"  

## 表的连接

1. 左外联结

left join 和left outer join本职上来说是没有什么区别的。比如你在SQL里写left join ，编译器编译后会形成left outer join。

1. Inner Join 

Inner Join 逻辑运算符返回满足第一个（顶端）输入与第二个（底端）输入联接的每一行。这个和用select查询多表是一样的效果，所以很少用到； 
outer join则会返回每个满足第一个（顶端）输入与第二个（底端）输入的联接的行。它还返回任何在第二个输入中没有匹配行的第一个输入中的行。关键就是后面那句，返回的多一些。所以通常意义上的left join就是left outer join。



## 练习题目

Student(S#,Sname,Sage,Ssex) 学生表
Course(C#,Cname,T#) 课程表
SC(S#,C#,score) 成绩表
Teacher(T#,Tname) 教师表

问题：
==**1、查询“001”课程比“002”课程成绩高的所有学生的学号；**==

select s.s#

**from (select S#, score from SC where C#='001') a,**

**(select S#, score from SC where C#='002' ) b**

where a.score > b.score

**and a.S# = b.s#;**

> 还没有办法明显的说清楚，这个逻辑是什么

**2、查询平均成绩大于60分的同学的学号和平均成绩；**

select S#, avg(score) mean_score

from SC

group by S#

having mean_score > 60;

==**3、查询所有同学的学号、姓名、选课数、总成绩；**==

select s.S#, s.Sname, count(c.C#) as course_number, sum(sc.score) as whole_score

from(Student s innor join SC sc

on s.S#= sc.S#

innor join Course c

on sc.C# = c.C#)

group by s.S#;

答案:

select s.S#, s.name, count(sc.C#), sum(sc.score)

from Student s **left outer join** SC sc

on s.S#=sc.S#

group by s.S#,**s.Sname**  # 为什么要groupby两个？

**4、查询姓“李”的老师的个数；**

select count(*)

from Teacher

where Tname like '李';

答案：

select count(**distinct**(T#))

from Teacher

where Tname like '李';

**5、查询没学过“叶平”老师课的同学的学号、姓名；**

select s.S#, s.Sname

from (select distinct(s.S#)

from Student s left join SC sc

on s.S#=sc.s#

left join Course c

on sc.C#= c.C#

left join Teacher t

on t.T#=c.T#

where t.Tname == '叶平') a,

(select distinct(S#) from Student) b,

Student

where a not in b;

答案：

select s.S#,s.Sname #不明白这里为什么要加表名

from Student s

where S# not in (select distinct(S.S#) 

from Student S, Course c, SC sc, Teacher t

where s.S#=sc.C#

and sc.C#= c.C#

and c.T#=t.T#

and t.Tname = '叶平') #注意一个=等号

逻辑是一样的，当时答案明显写的确定正确，简单。

==**6、查询学过“001”并且也学过编号“002”课程的同学的学号、姓名；**==

select s.S#,s.Sname

from Student s, Course c, SC sc

where s.S#=sc.S#

and sc.C#=c.C#

and c.Course ='001'

and c.Course = '002'

group by s.S#;

答案：

select Student.S#,Student.Sname
from Student,SC
where Student.S#=SC.S# and SC.C#=’001′and **exists( Select * from SC as SC_2 where SC_2.S#=SC.S# and SC_2.C#=’002′);**

> 第一，只需要连接s和sc表，因为sc表里面有c#课程号。
>
> 第二，逻辑是不一样的。不明白为什么不能使用group by，可以试一试（如果有表的，sql使用条件的话）

==**7、查询学过“叶平”老师所教的所有课的同学的学号、姓名；**==

叶平的所有课程

select c.C#

from Teacher t, Course c

where t.T#=c.T#

and Tname = '叶平';

如果用第6题的方法，我不知道现在一共有几个课

答案：

select s.S#, s.Sname

from student

where s.S# in (select count(c.C#)

from Teacher t, Course c

where t.T#=c.T#

and Tname = '叶平';) = (select sc.S# from  Course c, SC sc, Teacher t

where c.C#=SC.C#

and c.T#=t.T#

and Tname = '叶平'

group by sc.S#

having count(c.C#));

> having是和group by紧密相连的，having分两种，如果是having count（）>7就是筛选，如果having count（）那就是最后显示的结果。
>
> where是先于group by的。
>
> 本题的逻辑是：
>
> 1. 计算叶平课的数量
> 2. 计算上叶平课的学生中，上他的课的数量
> 3. 比较上面两个，获得名单
> 4. 获得除了学号以外的字段从student表里面
>
> sql确实很灵活
>
> where (新筛选3)=(新筛选2)

**8、查询所有课程成绩小于60分的同学的学号、姓名；**

select distinct(s.S#), s.Sname

from Student s

where s.S#in (select S#

from SC

where score < 60);

答案：

select S#,Sname
from Student
where S# not in (select Student.S# from Student,SC where S.S#=SC.S# and score>60);

> 此题，我觉得我的方法也是对的。
>
> 我的方式：有低于60分的就挑出来
>
> 答案：不在所有的高于60的（我反而觉得答案有些问题）

**9、查询没有学全所有课的同学的学号、姓名；**

第一个问题，所有课是什么。

和第七题很像。

select distinct(S.S#), S.Sname

from Student S

where S# in 

(select S.S# 

from (select S.S#, count(distinct(SC.C#)) as course_num

from Student S, SC

where S.S#=SC.S#

group by S.S#

having course_num < (select count(distinct(C#)) from Course )));

> 我的逻辑：
>
> 符合要求的表格的学号在
>
> 选出学号（选课数量< 全部的课））

答案：

> 答案的逻辑明显更简单

select s.Student,s.Sname

from Student s, SC

where s.S#= SC.S#

group by s.S#,s.Sname

having count(SC.C#) < (select count(C#) from Course);

**10、查询至少有一门课与学号为“1001”的同学所学相同的同学的学号和姓名；**

逻辑：

1. 1001学生学的课
2. 其他学生选的课in

select S.S#, S.Sname

from Student S, SC.C#

where S.S#=SC.S#

and SC.C# in (select C# 

from SC 

where S#='1001');

==**11、删除学习“叶平”老师课的SC表记录；**==

delete * 

from SC

where C# in (select SC.C# 

from SC, Teacher T, Course

where SC.C# = C.C#

and T.T#= C.T#

and T.Tname = '叶平');

答案：

Delect SC
from course ,Teacher
where Course.C#=SC.C# 

and Course.T#= Teacher.T# and Tname='叶平';

> delete的格式
>
> delete [表名]
>
> from
>
> 【delete再学一下】

==**12、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分**==

select C#, max(score), min(score)

from SC

group by C#;

答案：

SELECT L.C# 课程ID,L.score 最高分,R.score 最低分
FROM SC L ,SC R
WHERE L.C# = R.C#
and
L.score = (SELECT MAX(IL.score)
FROM SC IL,Student IM
WHERE IL.C# = L.C# and IM.S#=IL.S#
GROUP BY IL.C#)
and
R.Score = (SELECT MIN(IR.score)
FROM SC IR
WHERE IR.C# = R.C#
GROUP BY IR.C# );

> 这个貌似是把一个表，弄成两个表研究，但我并不明白为什么这么做。

==**13、查询学生平均成绩及其名次**==

第一，计算平均成绩

第二，利用平均成绩排名

select *, rank() over (order by avg(score) desc)

from (select S#, avg(score)

from SC

group by S#);

答案：

SELECT 1+(SELECT COUNT( distinct 平均成绩)
FROM (SELECT S#,AVG(score) 平均成绩
FROM SC
GROUP BY S# ) T1
WHERE 平均成绩 > T2.平均成绩) 名次, S# 学生学号,平均成绩
FROM (SELECT S#,AVG(score) 平均成绩 FROM SC GROUP BY S# ) T2
ORDER BY 平均成绩 desc;

> 再理解和实例安排

**Student(S#,Sname,Sage,Ssex) 学生表**

**Course(C#,Cname,T#) 课程表**

**SC(S#,C#,score) 成绩表**

**Teacher(T#,Tname) 教师表**

**14、查询各科成绩前三名的记录:(不考虑成绩并列情况)**

这个真的不会做

答案：

SELECT t1.S#,t1.C#, t1.Score
FROM SC t1
WHERE score IN (SELECT TOP 3 score
FROM SC
WHERE t1.C#= C#
ORDER BY score DESC)
ORDER BY t1.C#;

> 答案逻辑：
>
> 1. 每个科目前三名的分数在。。。里面
> 2. 分数是。。。
>
> 为啥感觉没对上呢。。。。
>
> 函数 top 3 score order by score desc取一个科目的前3名
>
> 是不是应该在加上c#和score共同对应呢？

**15、查询每门功成绩最好的前两名**

sc中（和上面是一样的呀）

答案：

SELECT t1.S# as 学生ID,t1.C# as 课程ID,Score as 分数

FROM SC t1
WHERE score IN (SELECT TOP 2 score
FROM SC
WHERE t1.C#= C#
ORDER BY score DESC )
ORDER BY t1.C#;

> 没错，和上一道题一个逻辑

## 微软的sql server文档

https://msdn.microsoft.com/zh-cn/library/bb510741.aspx

## 第二组面试题目

#### How to find nth highest salsay in SQL

