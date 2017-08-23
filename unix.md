# unix for data scientists

总结版小笔记

1. 地址：

   绝对地址：/

   相对地址：

   - 本级 .
   - 父级 ..
   - home ：~

2. command

   1. 地址、文件

      ls -a -l -al

      cd

      pwd

      mkdir

      cp

      mv

      clear

      man （在bash里面是 --help）

      ps -aef 看进程

      clear 清屏

   2. 读文件、处理文件

      echo 打印

      cat 读

      more 读（分页）

      less（不知道）

      uniq -c（count计数）unique

      - -c 计数
      - -u 不知道

      grep 取行（按匹配）

      - -i +‘文字或者正则表达式’ 取有这个字符的
      - -o 也不知道

      cut 取列（按位置）

      sort 排序（-nr逆序）

      - -nr 逆序
      - -f 不区分大小写
      - -k2 2这个数字可以换，是用第2列排序的意思
      - -t' ' 引号里面可以改，是用空格分开的意思

      head 前几行

      - -n +num 前几行

      tail 后几行

      sed 拆开（-e）通配标准是正则（不会）

      - -e 's/parchment/manuscript/g' /s和/g貌似是不变的，是用parchment替换manuscript的意思。

      wc 统计多少行

      - -l 估计是全部行统计的意思

   3. 符号

      | 管道：直接转给后面

      < 可以把文件放在后面

      \> 输出到

      \* 全部通配

      '‘’ 文件有空格的时候，可以使用

      ​

[TOC]



why unix command:

- File management
- Data manipulation
- Simple scripting using command line pipelines

Everything is a file or a process!



Paths in unix:

- Absolute path: start with /, separate directories by /
- Relative path: 
  - start at working directory
  - . refer to working directory
  - .. refer to level above

foo.txt

./foo.txt 根目录

../foo.txt  

~ : refer to a user's directory

~/foo.txt



pwd: present working directory

## Command lines

**ls** 显示当前目录的文件

**cd** change directory

**pwd**  present working directory

**cat** 显示文件内容 （不进入文件，直接打印）

**clear** 清屏

**man** manual 显示帮助手粗

**ls -l ** 显示long的files

**ls -a** 显示全部文件，包括隐藏的（all）

ls - la : long+all

**ls /Users/altina/** 显示各个文件夹的文件

**ls ~** 

**ls .. ** 父文件夹的内容

- List files and directories in UNIX : ls / ls -a 

- Change to a directory in UNIX: 

  cd . :current directory

  cd .. : parent directory

  ~ : home directory

- *-- wildcard 通配符（全部匹配） ls *.txt

- Make new directories : mkdir

- Name six simple UNIX commands

- cp : cp ../fruit.txt . copy file1 position1 把文件1拷贝到位置1：  $ cp ../'captailsquiz 15.txt' .  当自检名有空格的时候，可以用引号

- mv: mv ../shakspear.txt . 和copy用法一样，就是移动

## Redirecting Standard IO

> 可能是重定向的意思 就是R在屏幕打印还是在终端打印

FD: File Descriptor

FD0: standard input, 'stdin'

FD1: standard output, 'stdout'

FD2: standard error, 'stderr'

Redirect standard input to read from a file:

- Redirect standard input to read from a file 

  $ command < somefile

- Redirect standard output to write to file

  $ command > afile1

- Redirect standard output explicitly as FD 1

  $ command 1 > afile2

- Redirect standard error to write to a file

  $ command 2 > afile3

- Redirect standard error and standard output to different files

  $ command 2 > afile4 > afile5

- Redirect everything!

  $ command > onefile 2 > anotherfile < yetanotherfile

- Redirect standard output to append to a file

  $ command >> afile1

- Redirect standard error to append to a file

  $ command 2 >> afile3

- To redirect stderr and stdout to a file

  $ command > afile 2 >&1

more shakespears.txt   分页显示文件

cat shakespears.txt 全部显示文件

sort fruits.txt 排序

sort fruits.txt > fruits-sorted.txt 定向到fruits-sots.txt

cat < fruits-sorted.txt

uniq fruits-sorted.txt > fruits-unique.txt 去重

wc -l fruits.txt 统计行数

who > name.stxt 获得当前user

pwd; ls -l 一行里面有两个命令

ls -l > out.txt    ：> 输出到out.txt

(pwd; ls-l) > out.txt 不在屏幕上显示。

(pwd; ls -l) > /dev/null 不进行输出

## Pipes and Filters

- grep  #正则表达式抓取
- more
- less
- sort
- uniq

All will transform the raw files.

| : pipe

cat fruits.txt | uniq

ls -la | more

cat filename | wc # 行数

man cat | grep file

ls -l | grep txt | wc

who | sort > current_users 

sort fruits.txt | uniq | wc -l 

man cat | grep file | wc -l

ps -aef #电脑的终端的进程

ps -aef | sort > out.txt

## Commands for Data Science

- Sort, clean, cut and explore text data using Unix commands
- Plot data on the UNIX shell
- Use pipes and filters for quick data exploration in UNIX

Exploratory Data Analysis in UNIX

- cat
- grep
- wc
- sort
- uniq
- head  # 前几行
- tail # 后几行
- cut # 
- sed  # [string transformation](http://man.linuxde.net/sed) 
- find #quick search

Mission: 获得一个txt最常出现的几个单词。

```shell
sed -e 's/ /\'$'\n/g'
< shakespeare.txt |
sort |
sed '/^$d' |# remove blank lines
uniq -c |
sort -nr |
head -15 | #前15行
> count_vs_words
```

Which users run the most processes on my UNIX system?

```shell
ps -aef |
cut -c3-5 |
sort |
uniq -c |
sort -nr |
head -3
```

Transform fruits.txt into all caps for further processing.

```shell
tr '[a-z]' '[A-Z] < fruits.txt > fruits-AllCaps.txt  # 替换
```

>  cut、 sed都不会

Plotting the results of our exploration

*的通配符，可以用于匹配文件名

一些灵活的操作



```shell
v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ pwd   # present working directory
/e/ml/unix

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ ls  # list files
 all-fruits.txt         count_vs_words.txt   shakespeare.txt
'captailsquiz 15.txt'   fruits.txt
 count_vs_words         fruits-allCaps.txt

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ cat fruits.txt  # show the file
Peaches
Apples
Strawberries
Grapes
Oranges
Apples
Peaches
Melon

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ head -5 fruits.txt  # first 5 lines
Peaches
Apples
Strawberries
Grapes
Oranges

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ tail -2 fruits.txt  # last 2 lines(when I type 3, not work)
Peaches
Melon

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ (head -2; tail -2) < fruits.txt  # standard in from fruits.txt
Peaches
Apples
Peaches
Melon

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ paste fruits* > all-fruits.txt # paste all the files which can match fruits

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ cat all-fruits.txt
Peaches PEACHES
Apples  APPLES
Strawberries    STRAWBERRIES
Grapes  GRAPES
Oranges ORANGES
Apples  APPLES
Peaches PEACHES
Melon   MELON

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ wc shakespeare.txt  # calculate how much lines
 124505  901447 5583442 shakespeare.txt

v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ sed -e 's/ /\'$'\n/g' < shakespeare.txt  # 分开的意思，分开文字，变成类似列表的一个个元素。's/ /\'$'\n/g'应该是正则表达式的一个标准（但我不会）
# 有没有< 都可以
v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ sed -e 's/ /\'$'\n/g' < shakespeare.txt | sort # 排序
v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ sed -e 's/ /\'$'\n/g' < shakespeare.txt | sort | sed '/^$/d' | uniq -c # count 


$ sed -e 's/ /\'$'\n/g' < shakespeare.txt | sort | uniq -c | sort -nr # 逆序| head -15 前15个
 517068
  23244 the
  19542 I
  18302 and
  15623 to
  15551 of
  12532 a
  10824 my
   9576 in
   9081 you
   7851 is
   7531 that
   7068 And
   6948 not
   6722 with
v_tingltli@v_tingltli-PC0 MINGW64 /e/ml/unix
$ ps -aef | cut -c3-5 # cut c3-5意思是取第3-5的character的列

tin
tin
tin
tin

```

bash中：

- ctrl-shift-c 赋值
- ctrl-shift-v 粘贴
- command --help = man command
- 不支持more

画图工具： gnuplot



