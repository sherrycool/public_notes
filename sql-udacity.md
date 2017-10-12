## Aggregations

count

max

min

sum

avg

### Queries and Results

result is a new table

### steps:

1. join
2. restrcition
3. count (aggregation)

### SQL types

Text and string types

**text** — a string of any length, like Python **str** or **unicode** types.
**char(n)** — a string of exactly *n* characters.
**varchar(n)** — a string of up to *n* characters.

Numeric types

**integer** — an integer value, like Python **int**.
**real** — a floating-point value, like Python **float**. Accurate up to six decimal places.
**double precision** — a higher-precision floating-point value. Accurate up to 15 decimal places.
**decimal** — an exact decimal value.

Date and time types

**date** — a calendar date; including year, month, and day.
**time** — a time of day.
**timestamp** — a date and time together.

### Select  where

德摩根定律

not (A or B) = (not a) and (not b)

and, or, not

selece * from animals where

(not species = 'gorilla') and (not name = 'Max')

not (species = 'gorilla' or name = 'max')

species != 'gorilla' and name !='Max'

### Comparison Operators

<, >, =, !=, <=, >=

bewteen A and B (含本数)

###  Create a database, create a table, insert rows:

```sql
create database zoo;   # 创建一个database
use zoo;  # 进入这个database
create table animals (
name text,
species text,
birthdate date
); # 创建一个table，可以指定primary key和Foreign key
insert into animals values('Max', 'gorilla', '2015-11-12'); # 插入一条记录
```

## Zoo database structure

For reference, here's a list of all the tables in the zoo database:

##### animals

This table lists individual animals in the zoo. Each animal has only one row. There may be multiple animals with the same name, or even multiple animals with the same name and species.

- name — the animal's name (example: 'George')
- species — the animal's species (example: 'gorilla')
- birthdate — the animal's date of birth (example: '1998-05-18')

##### diet

This table matches up species with the foods they eat. Every species in the zoo eats at least one sort of food, and many eat more than one. If a species eats more than one food, there will be more than one row for that species.

- species — the name of a species (example: 'hyena')
- food — the name of a food that species eats (example: 'meat')

##### taxonomy

This table gives the (partial) biological taxonomic names for each species in the zoo. It can be used to find which species are more closely related to each other evolutionarily.

- name — the common name of the species (e.g. 'jackal')
- species — the taxonomic species name (e.g. 'aureus')
- genus — the taxonomic genus name (e.g. 'Canis')
- family — the taxonomic family name (e.g. 'Canidae')
- t_order — the taxonomic order name (e.g. 'Carnivora')

If you've never heard of this classification, don't worry about it; the details won't be necessary for this course. But if you're curious, Wikipedia articles [Taxonomy](http://en.wikipedia.org/wiki/Biological_classification) and [Biological classification](http://en.wikipedia.org/wiki/Biological_classification) may help.

##### ordernames

This table gives the common names for each of the taxonomic orders in the 

taxonomy

 table.

- t_order — the taxonomic order name (e.g. 'Cetacea')
- name — the common name (e.g. 'whales and dolphins')

### Creating tables

And here are the SQL commands that were used to create those tables. We won't cover the **create table** command until lesson 4, but it may be interesting to look at:

syntax:

create table {tablename} (

{column1} {type} [constraints],

{column2} {type} [constraints],

....

[row constraints]);

**types:** 不同的sql的type不全相同。

```sql
create table animals (  
       name text,
       species text,
       birthdate date);

create table diet (
       species text,
       food text);  

create table taxonomy (
       name text,
       species text,
       genus text,
       family text,
       t_order text); 

create table ordernames (
       t_order text,
       name text);
```

***Remember: In SQL, we always put string and date values inside single quotes.***

## Creating and Dropping database/tables

create database {name} [options];

drop database {name} [options];

drop table name [options];

**create a database in sqlite**:

在命令行直接输入 `sqlite3 {databasename}.db`，不是进入sqlite3再输入。

.databases # 显示databases

.quit #退出sql

命令行 `sqlite3 testDB.db .dump > testDB.sql `将这个database转化为sql

## Declaring primary keys

Primary key: a colu,m or columns that uniquely identify what each row in a table is about.

**一个primiary key:**

create table students (

id serial primary key,

name text,

birthdate date

);



**多个primary keys:**

create table postal_places (

postal_code text,

country text, 

name text,

==primary key== (postal_code, country)

);

## Declaring Retionships

第一个table：

products(sku, price, name)  #sku商品编号

第二个table：

sales(sku, sale_date,  count) #第二个table中sku必须再第一个table中，如果不在说明有错。

create table sales(

sku text ==references== products,

sale_date date,

count integer);

**references** provides referential integrity columns that are supposed to refer to each other are guaranteed to do so.

意味着关联约束，能起到检查的作用。

==Foregin Key==

A foreign key is a column or se of columns in one table, that uniquely indentifies rows in another table.

一个table可以有多个foreign keys

```sql
create table students(
id serial primay key,
name text);
```

- serial是一个type，序列的意思

create table courses(

id text primary key,

name text);



create table grades(

student integer references students (id),

course text reference courses (id),

grade text);

> 不能确定这个想法是不是正确的，一列如果是表1的主键，那绝不是表2的主键，而是表2的foreign键，biao2有个主键，表3有两个foreign keys，共同构成它的主键。

### Select clauses

**limit {count} [offset {skip}]**

- count: how many rows to return
- skip: how far into the result to start

.... limit 10 offset 150

return 10 rows, starting with the 151st row

**order by {columns} [desc]**

- columns: which columns to sort by, separated with commas (can be many columns)
- desc(optional): sort in reverse order descending

...order by species, name

**group by {columns}**: only by used by aggrerations

- columns: which columns to use as groupings when aggregating

select species, min(birthdate) from animials group by species;

for each species of animal, fine the smallest value of the birthdate column, that is t, the oldest animal's birthdate.

select name, count(*) as num from animals group by name;

别名 as

... **limit** *count*
Return just the first *count* rows of the result table.

... **limit** *count* **offset** *skip*
Return *count* rows starting after the first *skip* rows.

... **order by** *columns*
... **order by** *columns* **desc**
Sort the rows using the *columns* (one or more, separated by commas) as the sort key. Numerical columns will be sorted in numerical order; string columns in alphabetical order. With **desc**, the order is reversed (**desc**-ending order).

... **group by** *columns*
Change the behavior of aggregations such as **max**, **count**, and **sum**. With **group by**, the aggregation will return one row for each distinct value in *columns*.

==list ten per page: limit offset ?==

e.g.

count all the species:

select count(*) as num, species

from animal

group by species

order by num desc;

## Insert: adding rows

**insert into** *table* **(** *column1, column2, ...* **) values (** *val1, val2, ...* **);**If the values are in the same order as the table's columns (starting with the first column), you don't have to specify the columns in the **insert** statement:

**insert into** *table* **values (** *val1, val2, ...* **);**

insert into {table_name} valuse ({valuse1, value2, ....})

select_query = "select ..."

insert_query = "insert ..."

## Join

simple join:

way 1:

select animals.name

from animals join diet

on animals.species = diet.species

where food = 'fish';

way 2:

select name

from animals, diet

where animals.species = diet.species

and diet.food = 'fish';

## Having

==Where== is a restriction on the source tables.

==Having== is a restriction on the result ... after aggregation(group by ).

select food, count(food) as num

from animals a, diet d

where a.species = d.species

group by food

having num = 1;

## Self joins

You can view self-join as two identical tables. But in normalization you cannot create two copies of the table so you just simulate having two tables with self-join.

- 你需要的全部信息都在一张表里面
- 你需要对这样表配对、重排。。。

举例：

Example: an employee table where every employee can have a manager, and you want to list all employees and the name of their manager.



For example a table containing person information (Name, DOB, Address...) and including a column where the ID of the Father (and/or of the mother) is included. Then with a small query like

一个爸爸对多个孩子。

```
SELECT Child.ID, Child.Name, Child.PhoneNumber, Father.Name, Father.PhoneNumber
FROM myTableOfPersons As Child
LEFT OUTER JOIN  myTableOfPersons As Father ON Child.FatherId = Father.ID
WHERE Child.City = 'Chicago'  -- Or some other condition or none
```

一个room对应的两个人。

```sql
QUERY = '''
select a.id, b.id, a.building, a.room
       from residences as a, residences as b
 where a.building = b.building
   and a.room = b.room
   and a.id < b.id
 order by a.building, a.room;
```

为了不重复，人的名字a.id<b.id的要求。（体会）

## Count when join

为了获得有的商品只卖了一个， we’re using a **left join** instead of a plain **join**.

join = innor join 两张表都有的内容才显示

left join = left outer join 左表的全部内容+右表能和左表连上的内容

right join = right outer join

full out join

> *inner* join, and it is the most common kind of join — so common that SQL doesn’t actually make us say "inner join" to do one.

> A regular (inner) join returns only those rows where the two tables have entries matching the join condition. A **left join** returns all those rows, plus the rows where the *left* table has an entry but the right table doesn’t. And a **right join** does the same but for the *right* table.

> (Just as “join” is short for “inner join”, so too is “left join” actually short for “left outer join”. But SQL lets us just say “left join”, which is a lot less typing. So we’ll do that.)

```sql
select p.sku, count(*) as num
from products p
left join sales s
on p.sku = s.sku
group by p.sku
```

```sql
select programs.name, count(*) as num
       from programs join bugs
         on programs.filename = bugs.filename
       group by programs.name
       order by num;If you 
```

leave it as **count(\*)** or use a column from the **programs** table, your query will count entries that don't have bugs as well as ones that do.

count（右表的列）才能获得为0的program的bug数。

## Subqueries子查询

查询比平均体重轻的name和weight：

第一种

```sql
select name, weight
 from players,
(select avg(weight) as av
from players) as subq
where weight < av;
```

这一种，是两个表join后的

第二种

```sql
select name, weight
from players
where weight < (select avg(weight) from player);
```

## Views 试图

A view is a select query stored in the database in a way that lets you use it like a table.

syntax:

create view {viewname} as select .....

对aggregation非常有用

## 安装sqlite

SQLite 的一个重要的特性是零配置的，这意味着不需要复杂的安装或管理。本章将讲解 Windows、Linux 和 Mac OS X 上的安装设置。

在 Windows 上安装 SQLite

- 请访问 [SQLite 下载页面](http://www.sqlite.org/download.html)，从 Windows 区下载预编译的二进制文件。
- 您需要下载 [sqlite-tools-win32-x86-3180000.zip](http://www.sqlite.org/2017/sqlite-tools-win32-x86-3180000.zip)
  (1.56 MiB)压缩文件。
- 创建文件夹 C:\sqlite，并在此文件夹下解压上面两个压缩文件，将得到 sqlite3.def、sqlite3.dll 和 sqlite3.exe 文件。
- 添加 C:\sqlite 到 PATH 环境变量，最后在命令提示符下，使用 **sqlite3** 命令，将显示如下结果。

```
C:\>sqlite3
SQLite version 3.7.15.2 2013-01-09 11:53:05
Enter ".help" for instructions
Enter SQL statements terminated with a ";"
sqlite>
```

(重要的是，下载的sqlite文件中必须有exe文件，然后cmd的文件目录在有exe的那个文件夹里面)

### **如何设置或更改 PATH 系统变量？**

#### Windows

##### Windows 10 和 Windows 8

1. 在“搜索”中，搜索以下内容并进行选择：系统（控制面板）
2. 单击**高级系统设置**链接。
3. 单击**环境变量**。在**系统变量**部分中，找到并选择 `PATH` 环境变量。单击**编辑**。如果 `PATH` 环境变量不存在，请单击`新建`。
4. 在**编辑系统变量**（或**新建系统变量**）窗口中，指定 `PATH` 环境变量的值。单击**确定**。通过单击**确定**关闭所有剩余窗口。编辑：c:/sqlite



## DB-API

| Database system | DB-API module   |
| --------------- | --------------- |
| SQLite          | sqlite3         |
| PostgreSQL      | psycopg2        |
| ODBC            | pyodbc          |
| MySQL           | mysql.connector |



## python-sqlite 接口

select：

```python
import sqlite3

# Fetch some student records from the database.
db = sqlite3.connect("students")
c = db.cursor()
query = "select name, id from students;"
c.execute(query)
rows = c.fetchall()

# First, what data structure did we get?
print "Row data:"
print rows

# And let's loop over it too:
print
print "Student names:"
for row in rows:
  print "  ", row[0]

db.close()
```

insert：

```python
import sqlite3

db = sqlite3.connect("testdb")
c = db.cursor()
c.execute("insert into balloons values ('blue', 'water') ")
db.commit()
db.close()
```



## [SQLite 的操作（命令行、语句）](https://sqlite.org/cli.html)

> 这个文档很好，下次要再看

.open ex1.db   # 打开数据库

## Normalized Design

In a normalized database, the relationships among the tables match the relationships that are really there among the data.

1. Every row has the same number of columns.
2. There is a unique ==key==, and everything in a row says something about the key.
3. Facts that don't relate to the key belong in different tables.
4. Tables shouldn't imply relationships that don't exist. 

列和列之间没有关系，列只和key有关系。

> **1. Every row has the same number of columns.**
> In practice, the database system won't let us *literally* have different numbers of columns in different rows. But if we have columns that are sometimes empty (null) and sometimes not, or if we stuff multiple values into a single field, we're bending this rule.
>
> The example to keep in mind here is the **diet** table from the zoo database. Instead of trying to stuff multiple foods for a species into a single row about that species, we separate them out. This makes it much easier to do aggregations and comparisons.
>
> **2. There is a unique key and everything in a row says something about the key.**
> The key may be one column or more than one. It may even be the whole row, as in the **diet** table. But we don't have duplicate rows in a table.
>
> More importantly, if we are storing non-unique facts — such as people's names — we distinguish them using a unique identifier such as a serial number. This makes sure that we don't combine two people's grades or parking tickets just because they have the same name.
>
> **3. Facts that don't relate to the key belong in different tables.**
> The example here was the **items** table, which had items, their locations, and the location's street addresses in it. The address isn't a fact about the item; it's a fact about the location. Moving it to a separate table saves space and reduces ambiguity, and we can always reconstitute the original table using a **join**.
>
> **4. Tables shouldn't imply relationships that don't exist.**
> The example here was the **job_skills** table, where a single row listed one of a person's technology skills (like 'Linux') and one of their language skills (like 'French'). This made it look like their Linux knowledge was specific to French, or vice versa ... when that isn't the case in the real world. Normalizing this involved splitting the tech skills and job skills into separate tables.

## 一个例子

```sql lite
create table active(
imp_date integer(8),
id text(32) primary key,
last_active_day integer(8)
);

drop table user;

.separator ','
.import dataa.csv user;

.table

.show
.schema
# 直接import 不用建立表，但是要搞个字段名在原文件里面。
.output out.csv
.output stdout #重定向输出
select .....
```

```shell
head -1000 dataa.csv
wc dataa.csv
haad -120000 dataa.csv |tail -60000 > d1.csv
cat dataa.csv > dataa.txt

sqlite3 test # 进入某个数据库，否则内容是不能被保存的
```

# MYSQL

1366、导入bug

`alter database toutiao charset utf8;`

