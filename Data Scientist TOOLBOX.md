# Data Scientist TOOLBOX

## Basic command lines
Log in and off the data science toolbox

```shell
cd ml/dst
vagrant up
vagrant ssh
exit
```

Shut down the running machine

`vagrant halt`

Destroy the vagrant

`vagrant destroy`

Delect vagrant, visual box

Using  the installing file.

```shell
pwd
cd book/ch02
head -n 3 data/movies.txt
ls
echo 'Hello'\
'World.'|
wc
```

python script : fac.py

```python
#! /usr/bin/env python
def factorial(x):
  result = 1
  for i in xrange(2, x + 1):
    result *= i
  return result

if __name__ == '__main__':
  import sys
  x = int(sys.argv[1])
  print(factorial(x))
```

Run:

```shell
vagrant@data-science-toolbox:~/book/ch02$ ./fac.py 5
120
python fac.py 
```

Shell Function: fac()

```shell
vagrant@data-science-toolbox:~/book/ch02$ fac() {(echo 1;seq $1) | paste -s -d\* | bc;}
vagrant@data-science-toolbox:~/book/ch02$ fac 5
120
```

Alias

`alias l ='ls -1 --group-directories-first'(--是注视)`

```Shell
vagrant@data-science-toolbox:~/book/ch02$ type -a cd
cd is a shell builtin
vagrant@data-science-toolbox:~/book/ch02$ type -a pwd
pwd is a shell builtin
pwd is /bin/pwd
vagrant@data-science-toolbox:~/book/ch02$ type -a fac
fac is a function
fac () 
{ 
    ( echo 1;
    seq $1 ) | paste -s -d\* | bc
}
-- type is to check 
```

Combine command-line tools

```shell
vagrant@data-science-toolbox:~/book/ch02$ seq 30 | grep 5
5
15
25
vagrant@data-science-toolbox:~/book/ch02$ seq 30 | grep 5 | wc -l
3
```

Redirecting input and output

```shell
-- > create, overwrite, append into a file
vagrant@data-science-toolbox:~/book/ch02$ seq 10 > data/tennumbers.txt
vagrant@data-science-toolbox:~/book/ch02$ cat data/tennumbers.txt
1
2
3
4
5
6
7
8
9
10
vagrant@data-science-toolbox:~/book/ch02$ echo 'Hello, world' > hello-world
vagrant@data-science-toolbox:~/book/ch02$ cat hello-world
Hello, world
vagrant@data-science-toolbox:~/book/ch02$ echo 'nihao' > hello-world
vagrant@data-science-toolbox:~/book/ch02$ cat hello-world
nihao
vagrant@data-science-toolbox:~/book/ch02$ echo 'Hello, World' >> hello-world
vagrant@data-science-toolbox:~/book/ch02$ cat hello-world
nihao
Hello, World
-- < get info from a file, the same below
vagrant@data-science-toolbox:~/book/ch02$ cat hello-world | wc -c
19
vagrant@data-science-toolbox:~/book/ch02$ cat hello-world | wc -l
2
vagrant@data-science-toolbox:~/book/ch02$ < hello-world wc -l
2
vagrant@data-science-toolbox:~/book/ch02$ wc -w hello-world
3 hello-world
```

Working with the files

mv = move, ls = list, cd = change directory, rm = remove, cp = copy, mkdir = make a directory

```shell
vagrant@data-science-toolbox:~/book/ch02$ ls
data  fac.py  hello-world
vagrant@data-science-toolbox:~/book/ch02$ mv hello-world data
vagrant@data-science-toolbox:~/book/ch02$ ls
data  fac.py
vagrant@data-science-toolbox:~/book/ch02$ ls data
hello-world  movies.txt  tennumbers.txt
vagrant@data-science-toolbox:~/book/ch02$ cd data
vagrant@data-science-toolbox:~/book/ch02/data$ mv hello-world hello-world-old
vagrant@data-science-toolbox:~/book/ch02/data$ ls
hello-world-old  movies.txt  tennumbers.txt
vagrant@data-science-toolbox:~/book/ch02/data$ rm hello-world-old
vagrant@data-science-toolbox:~/book/ch02/data$ ls
movies.txt  tennumbers.txt
vagrant@data-science-toolbox:~/book/ch02/data$ cp movies.txt movies.txt.bak
vagrant@data-science-toolbox:~/book/ch02/data$ ls
movies.txt  movies.txt.bak  tennumbers.txt
vagrant@data-science-toolbox:~/book/ch02/data$ mkdir logs
vagrant@data-science-toolbox:~/book/ch02/data$ ls
logs  movies.txt  movies.txt.bak  tennumbers.txt
```

Help!

```
man cat
cat -- help
```

## Obtaining Data
OSEMN model

* obtaining data

Overview

* Download data from the internet
* Query database
* Content to web APIs
* Decompress files
* Convert Microsoft Excel spreadsheet into usable data

Decompressing files

```shell
tar -xzvf filename.tar.gz
unpack logs.tar.gz
```

unpack - a python script (unpack logs.tar.gz)

```python
#! /usr/bin/bash
# unpack: Extract common file formats

# Dispaly usage if no paramenters given
.....
```

Convert Microsoft Excel Spreadsheets

Shell tool: in2csv (excel to csv)

CSV (comma-separated values or character-separated values) shape:

field_name, field_name, field_name CRLF(a line break)

Aaa,bbb,ccc CRLF

Zzz,yyy,xxx CRLF

Kkk,hhh,sss

(last recond with no ending line break)

```shell
vagrant@data-science-toolbox:~/book/ch03$ in2csv data/imdb-250.xlsx > data/imbd-250.csv
vagrant@data-science-toolbox:~/book/ch03/data$ head -n 3 imbd-250.csv
Title,title trim,Year,Rank,Rank (desc),Rating,New in 2011 from 2010?,2010 rank,Rank Difference,
Sherlock Jr. (1924),SherlockJr.(1924),1924,221,30,8,y,n/a,n/a,
The Passion of Joan of Arc (1928),ThePassionofJoanofArc(1928),1928,212,39,8,y,n/a,n/a,
vagrant@data-science-toolbox:~/book/ch03/data$ in2csv imdb-250.xlsx | head | csvcut -c Title,Year,Rating | csvlook
|------------------------------------------+------+---------|
|  Title                                   | Year | Rating  |
|------------------------------------------+------+---------|
|  Sherlock Jr. (1924)                     | 1924 | 8       |
|  The Passion of Joan of Arc (1928)       | 1928 | 8       |
|  His Girl Friday (1940)                  | 1940 | 8       |
|  Tokyo Story (1953)                      | 1953 | 8       |
|  The Man Who Shot Liberty Valance (1962) | 1962 | 8       |
|  Persona (1966)                          | 1966 | 8       |
|  Stalker (1979)                          | 1979 | 8       |
|  Fanny and Alexander (1982)              | 1982 | 8       |
|  Beauty and the Beast (1991)             | 1991 | 8       |
|------------------------------------------+------+---------|
vagrant@data-science-toolbox:~/book/ch03/data$ man in2csv
No manual entry for in2csv
See 'man 7 undocumented' for help when manual pages are not available.
vagrant@data-science-toolbox:~/book/ch03/data$ in2csv --help  
```

in2csv --sheet   指定sheet

Query relational databases

Sql2csv (csvkit)

```shell
sql2csv --db 'sqlite:///data/iris.db' --query 'SELECT * FROM iris '\
> 'WHERE sepal_length > 7.5'
vagrant@data-science-toolbox:~/book/ch03/data$ sql2csv --db 'sqlite:///iris.db' --query 'SELECT * FROM iris WHERE sepal_length > 7.5'
sepal_length,sepal_width,petal_length,petal_width,species
7.6,3.0,6.6,2.1,Iris-virginica
7.7,3.8,6.7,2.2,Iris-virginica
7.7,2.6,6.9,2.3,Iris-virginica
7.7,2.8,6.7,2.0,Iris-virginica
7.9,3.8,6.4,2.0,Iris-virginica
7.7,3.0,6.1,2.3,Iris-virginica
```

Downloading from the internet

Curl : url (uniform resource locator)

```shell
Last login: Sun Oct  1 02:37:59 2017 from 10.0.2.2
vagrant@data-science-toolbox:~$ curl -s http://www.gutenberg.org/files/76/76-h/76-h.htm | head -n 20
<?xml version="1.0" encoding="utf-8"?>

<!DOCTYPE html
   PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" >

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta name="generator" content="HTML-Kit Tools HTML Tidy plugin" />
    <title>
      HUCKLEBERRY FINN, By Mark Twain, Complete
    </title>
    <style type="text/css" xml:space="preserve">

    body { margin:5%; background:#faebd0; text-align:justify}
    P { text-indent: 1em; margin-top: .25em; margin-bottom: .25em; }
    H1,H2,H3,H4,H5,H6 { text-align: center; margin-left: 15%; margin-right: 15%; }
    hr  { width: 50%; text-align: center;}
    .foot { margin-left: 20%; margin-right: 20%; text-align: justify; text-indent: -3em; font-size: 90%; }
    blockquote {font-size: 97%; font-style: italic; margin-left: 10%; margin-right: 10%;}
```

解决乱码问题：http://www.xuebuyuan.com/1047685.html

```shell
set LANG='utf-8'
export LANG
curl -s http://baidu.com
```

get the HTTP header

```shell
vagrant@data-science-toolbox:~$ curl -I http://www.gutenberg.org/files/76/76-h/76-h.htm
HTTP/1.1 403 Forbidden
Server: Apache
Last-Modified: Wed, 03 Sep 2014 21:20:07 GMT
Accept-Ranges: none
Content-Length: 1318
X-Frame-Options: sameorigin
X-Connection: Close
Content-Type: text/html
X-Powered-By: 3
X-Cacheable: NO: beresp.status
Date: Sun, 01 Oct 2017 03:32:38 GMT
X-Varnish: 1498563373
Age: 0
Via: 1.1 varnish
```

curl -s url address     --s:silence

Curl -u username:password ftp://host/file

curl -L j.mp/locatbbar  --L: shortened url

curl _I       -- header of HTTP

Calling Web APIs

Web API: application programming interface. Most web APIs return data in a structured format, such as JSON, XML.

```shell
vagrant@data-science-toolbox:~$ curl -s http://api.randomuser.me | jq '.'
```

Don't know why the data is empty.

Jq : display the data in a nice way.

Some web APIs return data in a streaming manner. You connect to is ,the data will  continue to pour in forever.

Some APIs require to log in using the OAuth protocol. Tool: curlicue.

(这个先不弄，配置的时候发现没有网址)

## Creating Reusable Command-line Tools
One-liner

Shell scripting

[Classsic Shell Scripting] by Robbins & Beebe (2005)

Converting one-liners into shell scripts

```shell
vagrant@data-science-toolbox:~$ curl -s http://www.gutenberg.org/files/76/76-0.txt |  
tr '[:upper:]' '[:lower:]' | 
grep -oE '\w+' | 
sort | 
uniq -c | 
sort -nr | 
head -n 10
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
```

explain: downloading the ebook using curl.

converting the entire text to lowercase using tr.

extracting all the words using grep and putting each word on a separate line.

Sorting the words in alphabetical order using sort.

removing all the duplicates and counting how often each word appears in the list using uniq.

Sorting this list of unique words by their count in descending order using sort.

keeping only the top 10 lines using head.

Steps to convert a one-liner to a shell script.

1. Copy and paste the one-liner into a file
2. Add execute permissions.
3. Define a so-called shebang.
4. Remove the fixed input part.
5. Add a parameter.
6. Optionally extend your PATH.

1. Get the script file

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-1.sh
curl -s http://www.gutenberg.org/cache/epub/76/pg76.txt | 
tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort | 
uniq -c | sort -nr | head -n 10
vagrant@data-science-toolbox:~/book/ch04$ ./top-words-1.sh
-bash: ./top-words-1.sh: Permission denied
```

permission denied. You can use sudo

Echo "!!" > filename -- save the last used command line to a file. Note that you need use double quote. (单引号没效果)

```shell
vagrant@data-science-toolbox:~/book/ch04$ curl -s http://www.gutenberg.org/files/76/76-0.txt |  tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |  uniq -c | sort -nr | head -n 10
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
vagrant@data-science-toolbox:~/book/ch04$ echo "!!" > top-words-01.sh
echo "curl -s http://www.gutenberg.org/files/76/76-0.txt |  tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |  uniq -c | sort -nr | head -n 10" > top-words-01.sh
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-01.sh
curl -s http://www.gutenberg.org/files/76/76-0.txt |  tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |  uniq -c | sort -nr | head -n 10

vagrant@data-science-toolbox:~/book/ch04$ curl -s http://www.gutenberg.org/files/76/76-0.txt | 
> tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort | 
> uniq -c | sort -nr | head -n 10
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
vagrant@data-science-toolbox:~/book/ch04$ echo '!!' > top-words-1-new.sh
vagrant@data-science-toolbox:~/book/ch04$ ./top-words-1-new.sh
-bash: ./top-words-1-new.sh: Permission denied
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-1-new.sh
!!
```

permission denied: use bash (command)

```shell
vagrant@data-science-toolbox:~/book/ch04$ ./top-words-01.sh
-bash: ./top-words-01.sh: Permission denied
vagrant@data-science-toolbox:~/book/ch04$ bash ./top-words-01.sh
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
```

2. Add permission to execute

chmod u+x filename

```shell
vagrant@data-science-toolbox:~/book/ch04$ curl -s http://www.gutenberg.org/files/76/76-0.txt |  tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |  uniq -c | sort -nr | head -n 10
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
vagrant@data-science-toolbox:~/book/ch04$ echo "!!" > top-words-02.sh
echo "curl -s http://www.gutenberg.org/files/76/76-0.txt |  tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |  uniq -c | sort -nr | head -n 10" > top-words-02.sh
vagrant@data-science-toolbox:~/book/ch04$ ls -l top-words-0{1,2}.sh
-rw-rw-r-- 1 vagrant vagrant 140 Oct  1 07:37 top-words-01.sh
-rw-rw-r-- 1 vagrant vagrant 140 Oct  1 07:55 top-words-02.sh
vagrant@data-science-toolbox:~/book/ch04$ chmod u+x top-words-02.sh
vagrant@data-science-toolbox:~/book/ch04$ ls -l top-words-0{1,2}.sh
-rw-rw-r-- 1 vagrant vagrant 140 Oct  1 07:37 top-words-01.sh
-rwxrw-r-- 1 vagrant vagrant 140 Oct  1 07:55 top-words-02.sh
vagrant@data-science-toolbox:~/book/ch04$ ./top-words-02.sh
   6439 and
   5077 the
   3666 i
   3258 a
   3022 to
   2567 it
   2086 t
   2044 was
   1847 he
   1777 of
```

可以执行的命令（有权限），ls -l 显示为绿色的

3. Define Shebang

Instruct the system which executable should be used to interpret the commands.

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-03.sh
#!/usr/bin/env bash
curl -s http://www.gutenberg.org/files/76/76-0.txt |
tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |
uniq -c | sort -nr | head -n 10
```

```
#! /usr/bin/bash
#! /usr/bin/python

如果bash or python装在其他位置
#! /usr/bin/env bash
#! /usr/bin/env python
```

如果没有定义，默认使用bash

Env command-line tool is aware  where bash and python are installed.

4. Remove Fixed input

(remove the web address)

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-4.sh
#!/usr/bin/env bash
tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |
uniq -c | sort -nr | head -n 10

vagrant@data-science-toolbox:~/book/ch04$ cat data/janeeyer.txt | ./top-words-4.sh
   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
   5318 to
   4571 a
   4484 of
   3692 ldquo
   3650 rdquo
```

利用管道调用

（https://www.gutenberg.org/files/1260/1260-h/1260-h.htm） 国内可访问，不需要vpn

5. Parameterize

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat top-words-5.sh
#!/usr/bin/env bash
NUM_WORDS="$1"
tr '[:upper:]' '[:lower:]' | grep -oE '\w+' | sort |
uniq -c | sort -nr | head -n $NUM_WORDS
vagrant@data-science-toolbox:~/book/ch04$ cat data/janeeyer.txt | ./top-words-5.sh 15
   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
   5318 to
   4571 a
   4484 of
   3692 ldquo
   3650 rdquo
   3066 you
   2826 in
   2527 was
   2431 it
   2236 my
vagrant@data-science-toolbox:~/book/ch04$ cat data/janeeyer.txt | top-words-5.sh 5
top-words-5.sh: command not found
vagrant@data-science-toolbox:~/book/ch04$ cat data/janeeyer.txt |bash top-words-5.sh 5
   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
```

6. Extend your PATH

Execute your command-line tools from everywhere.

In the past, you need to navigate to eat directory when it's in or include the full path name.

Bash needs to know where to look for your command-line tools. The variable call PATH.

Check the path.

```shell
vagrant@data-science-toolbox:~/book/ch04$ echo $PATH | fold
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/loc
al/games:/home/vagrant/tools:/usr/lib/go/bin:/home/vagrant/.go/bin:/home/vagrant
/.data-science-at-the-command-line/tools:/home/vagrant/.bin
vagrant@data-science-toolbox:~/book/ch04$ echo $PATH | tr : '\n' | sort
/bin
/home/vagrant/.bin
/home/vagrant/.data-science-at-the-command-line/tools
/home/vagrant/.go/bin
/home/vagrant/tools
/sbin
/usr/bin
/usr/games
/usr/lib/go/bin
/usr/local/bin
/usr/local/games
/usr/local/sbin
/usr/sbin
```

change the PATH permanently, edit the .bashrc or .profile file located in your home directory.

create a folder call tools and put all your command-line scripts in the folder, and change the path including the fold location.

Create a R/python script

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat top-words.py
#!/usr/bin/env python
import re
import sys
from collections import Counter
num_words = int(sys.argv[1])
text = sys.stdin.read().lower()
words = re.split('\W+', text)
cnt = Counter(words)
for word, count in cnt.most_common(num_words):
    print "%7d %s" % (count, word)
vagrant@data-science-toolbox:~/book/ch04$ cat top-words.R
#!/usr/bin/env Rscript
n <- as.integer(commandArgs(trailingOnly = TRUE))
f <- file("stdin")
lines <- readLines(f)
words <- tolower(unlist(strsplit(lines, "\\W+")))
counts <- sort(table(words), decreasing = TRUE)
counts_n <- counts[1:n]
cat(sprintf("%7d %s\n", counts_n, names(counts_n)), sep = "")
close(f)
vagrant@data-science-toolbox:~/book/ch04$ < data/janeeyer.txt ./top-words.py 7
   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
   5318 to
   4571 a
vagrant@data-science-toolbox:~/book/ch04$ < data/janeeyer.txt ./top-words.R 6
   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
   5318 to
vagrant@data-science-toolbox:~/book/ch04$ < data/janeeyer.txt ./top-words-5.sh 5   8138 p
   8033 the
   7646 i
   6699 and
   5383 nbsp
```

(注意，bash R python都能分清楚，参数和文件对象)

When everything is a command-line tool, you can even split up the task into subtasks, and combine a Bash command-line tool with. A python command-line tool.

Processing streaming data from standard input

Data is nonstop stream.

(awk sort can't use streaming data)

R和python都可以处理数据流输入，用循环

```shell
vagrant@data-science-toolbox:~/book/ch04$ cat stream.py
#!/usr/bin/env python
from sys import stdin, stdout
while True:
    line = stdin.readline()
    if not line:
        break
    stdout.write("%d\n" % int(line)**2)
    stdout.flush()
vagrant@data-science-toolbox:~/book/ch04$ cat stream.R
#!/usr/bin/env Rscript
f <- file("stdin")
open(f)
while(length(line <- readLines(f, n = 1)) > 0) {
	write(as.integer(line)^2, stdout())
}
```

## Scrubbing Data
tools：

* cut
* sed
* jq
* csvgrep
* awk
* header
* csvsql

Overview

* Convert data from one format to another
* Apply SQL queries to CSV
* Filter lines
* Extract and replace values
* Sprite, merge, and extract columns

Filter:

based on location:

```shell
vagrant@data-science-toolbox:~/book/ch05/data$ seq -f 'Line %g' 10
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
vagrant@data-science-toolbox:~/book/ch05/data$ seq -f 'Line %4g' 10
Line    1
Line    2
Line    3
Line    4
Line    5
Line    6
Line    7
Line    8
Line    9
Line   10
vagrant@data-science-toolbox:~/book/ch05/data$ seq 3 5
3
4
5
vagrant@data-science-toolbox:~/book/ch05/data$ seq -f 'lines %g' 10 | tee lines
lines 1
lines 2
lines 3
lines 4
lines 5
lines 6
lines 7
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines head -n 3
lines 1
lines 2
lines 3
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed -n '1,3p'
lines 1
lines 2
lines 3
vagrant@data-science-toolbox:~/book/ch05/data$ < lines awk 'NR<=3'
lines 1
lines 2
lines 3

```

Seq : 生成序列

-f : format

%g： 代表位数

Tee 标准输入、输出，就是生成一个标准输出的文件，后面可以读，不是内存中的变量，而是>生成的文件。

```shell
vagrant@data-science-toolbox:~/book/ch05/data$ tee test
a
a
b
b
c
c
d
d
vagrant@data-science-toolbox:~/book/ch05/data$ cat test
a
b
c
d  (control d 结束输入)
vagrant@data-science-toolbox:~/book/ch05/data$ ls
alice.txt     Iris-setosa.csv      lines            test        wiki.html
iris.csv      Iris-versicolor.csv  names-comma.csv  tips.csv
irismeta.csv  Iris-virginica.csv   names.csv        users.json
```

head awk sed是取行。

head -n  取前num行

sed -n '1,3p' 取1-3行（从前面数）

awk 'NR<=3' NR代表行数

```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < lines tail -n 3
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed '1,3d'
lines 4
lines 5
lines 6
lines 7
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed -n '1,3!p'
lines 4
lines 5
lines 6
lines 7
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines tail -n +4
lines 4
lines 5
lines 6
lines 7
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines head -n +3
lines 1
lines 2
lines 3
vagrant@data-science-toolbox:~/book/ch05/data$ < lines head -n -3
lines 1
lines 2
lines 3
lines 4
lines 5
lines 6
lines 7
vagrant@data-science-toolbox:~/book/ch05/data$ < lines tail -n +3
lines 3
lines 4
lines 5
lines 6
lines 7
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines tail -n -3
lines 8
lines 9
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines tail -n 4 | head -n 3
lines 7
lines 8
lines 9
vagrant@data-science-toolbox:~/book/ch05/data$ sed -n '4,6p' lines
lines 4
lines 5
lines 6
vagrant@data-science-toolbox:~/book/ch05/data$ < lines awk '(NR>3)&&(NR<8)'
lines 4
lines 5
lines 6
lines 7
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed -n '1~2p'
lines 1
lines 3
lines 5
lines 7
lines 9
vagrant@data-science-toolbox:~/book/ch05/data$ < lines awk 'NR%2'
lines 1
lines 3
lines 5
lines 7
lines 9
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed -n '0~2p'
lines 2
lines 4
lines 6
lines 8
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ <lines awk '(NR+1)%2'
lines 2
lines 4
lines 6
lines 8
lines 10
vagrant@data-science-toolbox:~/book/ch05/data$ < lines sed -n '3~4p'
lines 3
lines 7
(从第三个开始，取第四个。)
```

Based on patterns:

具体的文字匹配和正则表达式

```shell
vagrant@data-science-toolbox:~/book/ch05/data$ grep -i chapter alice.txt
CHAPTER I. Down the Rabbit-Hole
CHAPTER II. The Pool of Tears
CHAPTER III. A Caucus-Race and a Long Tale
CHAPTER IV. The Rabbit Sends in a Little Bill
CHAPTER V. Advice from a Caterpillar
CHAPTER VI. Pig and Pepper
CHAPTER VII. A Mad Tea-Party
CHAPTER VIII. The Queen's Croquet-Ground
CHAPTER IX. The Mock Turtle's Story
CHAPTER X. The Lobster Quadrille
CHAPTER XI. Who Stole the Tarts?
CHAPTER XII. Alice's Evidence
vagrant@data-science-toolbox:~/book/ch05/data$ grep -E '^CHAPTER (.*)\.The' alice.txt
vagrant@data-science-toolbox:~/book/ch05/data$ grep -E '^CHAPTER (.*)\. The' alice.txt
CHAPTER II. The Pool of Tears
CHAPTER IV. The Rabbit Sends in a Little Bill
CHAPTER VIII. The Queen's Croquet-Ground
CHAPTER IX. The Mock Turtle's Story
CHAPTER X. The Lobster Quadrille

^CHAPTER (.*)\. The
表示chapter开头 通配任何字符（\n）外任意次，然后是.(\.代表点号)，然后是空格，然后是The
```

grep 抓取，-E按正则表达式。^开头，\转义符号，() 是为了提取匹配的字符串。表达式中有几个()就有几个相应的匹配字符串，.和*通配符，.匹配除换行符 \n 之外的任何单字符, ***匹配前面的子表达式零次或多次.
http://www.runoob.com/regexp/regexp-syntax.html

Based on randomness
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ seq 1000 | sample -r 1% | jq -c '{line: .}'
{"line":39}
{"line":41}
{"line":115}
{"line":248}
{"line":263}
{"line":291}
{"line":295}
{"line":302}
{"line":315}
{"line":327}
{"line":390}
{"line":462}
{"line":505}
{"line":517}
{"line":798}

vagrant@data-science-toolbox:~/book/ch05/data$ seq 1000 | sample -r 1% -d 1000 -s 5 | jq -c '{line: .}'
{"line":47}
{"line":84}
{"line":242}
{"line":251}
{"line":332}
{"line":515}
```
sample -r (rate 按比率抽取)
jq 是json的解析器，也可以用于其他场合,生成固定模式的序列，有点像sed -f ‘line：%g’
sample 也可以用于数据流中 -d延迟毫秒

Extracting values
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ grep -i chapter alice.txt
CHAPTER I. Down the Rabbit-Hole
CHAPTER II. The Pool of Tears
CHAPTER III. A Caucus-Race and a Long Tale
CHAPTER IV. The Rabbit Sends in a Little Bill
CHAPTER V. Advice from a Caterpillar
CHAPTER VI. Pig and Pepper
CHAPTER VII. A Mad Tea-Party
CHAPTER VIII. The Queen's Croquet-Ground
CHAPTER IX. The Mock Turtle's Story
CHAPTER X. The Lobster Quadrille
CHAPTER XI. Who Stole the Tarts?
CHAPTER XII. Alice's Evidence
vagrant@data-science-toolbox:~/book/ch05/data$ grep -i chapter alice.txt | cut -d' ' -f3-
Down the Rabbit-Hole
The Pool of Tears
A Caucus-Race and a Long Tale
The Rabbit Sends in a Little Bill
Advice from a Caterpillar
Pig and Pepper
A Mad Tea-Party
The Queen's Croquet-Ground
The Mock Turtle's Story
The Lobster Quadrille
Who Stole the Tarts?
Alice's Evidence
vagrant@data-science-toolbox:~/book/ch05/data$ sed -rn 's/^CHAPTER ([IVXLCDM]{1,}\. (.*)$/\2/p' alice.txt

vagrant@data-science-toolbox:~/book/ch05/data$ grep -i chapter alice.txt | cut -c 9-
I. Down the Rabbit-Hole
II. The Pool of Tears
III. A Caucus-Race and a Long Tale
IV. The Rabbit Sends in a Little Bill
V. Advice from a Caterpillar
VI. Pig and Pepper
VII. A Mad Tea-Party
VIII. The Queen's Croquet-Ground
IX. The Mock Turtle's Story
X. The Lobster Quadrille
XI. Who Stole the Tarts?
XII. Alice's Evidence
```
grep -i : 不区分大小写
cut 截取列。 -d 分隔符， -f3-从第三列到最后. -c 数字符，9-从第9个到最后
sed 也可以实现一样的功能，但是我没有做到。
sed 's/.../.../p' 截取第一个三个点的，替换为第二个三个点的。例子中估价是取第二列。

```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < alice.txt grep -oE '\w{2,}' | head -n 10
Project
Gutenberg
Alice
Adventures
in
Wonderland
by
Lewis
Carroll
This
```
grep -oE 只匹配正则表达式
\w：匹配包括下划线的任何单词字符。类似但不等价于“[A-Za-z0-9_]”，这里的"单词"字符使用Unicode字符集。
\W：匹配任何非单词字符。等价于“[^A-Za-z0-9_]”。
{2,}表示前面的内容出现2次及以上。
() 是为了提取匹配的字符串。表达式中有几个()就有几个相应的匹配字符串。（可以用在分组，或者前面不止一个字符，可在后面表示次数）
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < alice.txt tr '[:upper:]' '[:lower:]' | grep -oE '\w{2,}' | grep -E '^a.*e$' | sort | uniq -c |sort -nr |
> awk '{print $2","$1}' | header -a word,count | head | csvlook
|-------------+--------|
|  word       | count  |
|-------------+--------|
|  alice      | 403    |
|  are        | 73     |
|  archive    | 13     |
|  agree      | 11     |
|  anyone     | 5      |
|  alone      | 5      |
|  age        | 4      |
|  applicable | 3      |
|  anywhere   | 3      |
|-------------+--------|
```
tr '[:upper:]' '[:lower:]' 大写都改成小写
grep -oE '\w{2,}' 截取出所有单词
grep -E '^a.*e$' 截取出单词a开头e结尾
sort 排序
uniq -c 计数
sort -nr 数字逆序
awk '{print $2","$1}' 重新排顺序
header -a word,count  加字段名

Replace and deleting values
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ echo 'Hello world!' | tee hello
Hello world!
vagrant@data-science-toolbox:~/book/ch05/data$ cat hello
Hello world!
vagrant@data-science-toolbox:~/book/ch05/data$ < hello tr ' ' '_'
Hello_world!
vagrant@data-science-toolbox:~/book/ch05/data$ < hello tr '!' "_?"
Hello world_
vagrant@data-science-toolbox:~/book/ch05/data$ < hello tr '!' '_?'
Hello world_
vagrant@data-science-toolbox:~/book/ch05/data$ < hello tr '!' '?'
Hello world?
vagrant@data-science-toolbox:~/book/ch05/data$ <hello tr -d -c '[a-z]'
elloworld
```
tr -d 删除
tr -c 取补集
```shell
elloworldvagrant@data-science-toolbox:~/book/ch05/data$ echo 'hello world!' | tr '[a-z]' '[A-Z]'
HELLO WORLD!
vagrant@data-science-toolbox:~/book/ch05/data$ echo 'hello world!' | tr '[:lower:]' '[:upper:]'
HELLO WORLD!
vagrant@data-science-toolbox:~/book/ch05/data$ echo '   hello     world!' | sed -re 's/hello/bye/;s/\s+/ /g;s/\s+//'
bye world!
```
sed -re
用；号连接了3个需要替换的部分。s代表替换。g表示global就是每个都要替换，而不是只替换第一个。第一个，hello换成bye。第二个\s+代表匹配任何空白字符，都匹配成空格。第三个，空白字符匹配为空。

Dealing with:
* missing values
* inconsistencies
* errors
* weird characters
* uninteresting columns
1. Get the desired format of the data
2. Filtering
3. Replacing
4. Merging
Tools:
- cut
- sed
- jq
- csvgrep
- uniq -c
- awk
- header
```shell
vagrant@data-science-toolbox:~/book/ch05$ seq 5 | header -a value | csvsql --query "SELECT SUM(value) AS sum FROM stdin"
sum
15
```
Convert data
json / HTML /XML --- CSV
- curl
- scrape
- xml2json
- jq
- json2csv
```shell
vagrant@data-science-toolbox:~/book/ch05$ curl -sL 'http://en.wikipedia.org/wiki/List_of_countries_and_territories_by_border/area_ratio' > wiki.html
vagrant@data-science-toolbox:~/book/ch05$ head -n 10 wiki.html
<!DOCTYPE html>
<html class="client-nojs" lang="en" dir="ltr">
<head>
<meta charset="UTF-8"/>
下载一个wikipedia的网页（XML）
<wiki.html grep -A 50 wikitable
vagrant@data-science-toolbox:~/book/ch05$ <wiki.html grep wikitable -A 50
这两个效果是一样的，区别是参数和对象的顺序,看看wiki网页里面的表格
vagrant@data-science-toolbox:~/book/ch05$ < wiki.html grep wikitable -A 21
<table class="wikitable sortable">
<tr>
<th>Rank</th>
<th>Country or territory</th>
<th>Total length of land borders (km)</th>
<th>Total surface area (km²)</th>
<th>Border/area ratio (km/km²)</th>
</tr>
<tr>
<td>1</td>
<td>Vatican City</td>
<td>3.2</td>
<td>0.44</td>
<td>7.2727273</td>
</tr>
<tr>
<td>2</td>
<td>Monaco</td>
<td>4.4</td>
<td>2</td>
<td>2.2000000</td>
</tr>
前面这些行可以看出来表结构：
第0列：rank
第1列：country
第二列：border
第三列：surface
第四列：border/area
grep -a wikitable出现之后的21行正好有表结构和第一个记录。

vagrant@data-science-toolbox:~/book/ch05$ < wiki.html scrape -b -e 'table.wikitable > tr:not(:first-child)' > table.html
vagrant@data-science-toolbox:~/book/ch05$ head -n 10 table.html
<!DOCTYPE html>
<html>
<body>
<tr>
<td>1</td>
<td>Vatican City</td>
<td>3.2</td>
<td>0.44</td>
<td>7.2727273</td>
</tr>
scrape应该是从xml文件中抽取内容(wikitable) tr:not(:first-child)'不取首行，这样才能用xml2json

vagrant@data-science-toolbox:~/book/ch05$ < table.html xml2json > table.json
vagrant@data-science-toolbox:~/book/ch05$ jq '.' table.json | head -n 20
{
  "html": {
    "body": {
      "tr": [
        {
          "td": [
            {
              "$t": "1"
            },
            {
              "$t": "Vatican City"
            },
            {
              "$t": "3.2"
            },
            {
              "$t": "0.44"
            },
            {
将html转换为json文件

vagrant@data-science-toolbox:~/book/ch05$ < table.json jq -c '.html.body.tr[] | {country: .td[1][],border: .td[2][], surface: .td[3][]}' > countries.json
grant@data-science-toolbox:~/book/ch05$ head -n 20 countries.json
{"country":"Vatican City","border":"3.2","surface":"0.44"}
{"country":"Monaco","border":"4.4","surface":"2"}
{"country":"San Marino","border":"39","surface":"61"}
{"country":"Liechtenstein","border":"76","surface":"160"}
{"country":"Sint Maarten (Netherlands)","border":"10.2","surface":"34"}
{"country":"Andorra","border":"120.3","surface":"468"}
{"country":"Gibraltar (United Kingdom)","border":"1.2","surface":"6"}
{"country":"Saint Martin (France)","border":"10.2","surface":"54"}
{"country":"Luxembourg","border":"359","surface":"2586"}
{"country":"Palestinian territories","border":"466","surface":"6220"}
{"country":"Brunei","border":"381","surface":"5765"}
{"country":"Slovenia","border":"1334","surface":"20273"}
{"country":"The Gambia","border":"740","surface":"11295"}
{"country":"Kosovo","border":"701","surface":"10887"}
从json文件中抽取几列 新json


vagrant@data-science-toolbox:~/book/ch05$ < countries.json json2csv -p -k country,border,surface > countries.csv
vagrant@data-science-toolbox:~/book/ch05$ head -n 10 countries.csv | csvlook
|-----------------------------+--------+----------|
|  country                    | border | surface  |
|-----------------------------+--------+----------|
|  Vatican City               | 3.2    | 0.44     |
|  Monaco                     | 4.4    | 2        |
|  San Marino                 | 39     | 61       |
|  Liechtenstein              | 76     | 160      |
|  Sint Maarten (Netherlands) | 10.2   | 34       |
|  Andorra                    | 120.3  | 468      |
|  Gibraltar (United Kingdom) | 1.2    | 6        |
|  Saint Martin (France)      | 10.2   | 54       |
|  Luxembourg                 | 359    | 2586     |
|-----------------------------+--------+----------|
将json转换成csv文件
```

总结一下：从html-csv
1. 下载html文件（找个表格的）curl > filename.html
2. 找到表格  grep wikitable 熟悉表格结构
3. 从html文件中截取表格 scrape -b -e | tr > table.html 不要表头的内容。（具体也不会写）
4. 从xml文件（html）转化成json xml2json > table.json
5. 从json文件中截取需要的列  jq -c > table2.json
6. 将json文件转化成csv json2csv -p -k > file.csv
(先这样的，后面再学习）

Common Scrub Operations for CSV

1. Extracting and reordering columns
```shell
vagrant@data-science-toolbox:~/book/ch05$ head -n 5 data/iris.csv | csvlook
|---------------+-------------+--------------+-------------+--------------|
|  sepal_length | sepal_width | petal_length | petal_width | species      |
|---------------+-------------+--------------+-------------+--------------|
|  5.1          | 3.5         | 1.4          | 0.2         | Iris-setosa  |
|  4.9          | 3.0         | 1.4          | 0.2         | Iris-setosa  |
|  4.7          | 3.2         | 1.3          | 0.2         | Iris-setosa  |
|  4.6          | 3.1         | 1.5          | 0.2         | Iris-setosa  |
|---------------+-------------+--------------+-------------+--------------|


vagrant@data-science-toolbox:~/book/ch05$ <data/iris.csv csvcut -c sepal_length,petal_length,sepal_width,petal_width | head -n 5 | csvlook
|---------------+--------------+-------------+--------------|
|  sepal_length | petal_length | sepal_width | petal_width  |
|---------------+--------------+-------------+--------------|
|  5.1          | 1.4          | 3.5         | 0.2          |
|  4.9          | 1.4          | 3.0         | 0.2          |
|  4.7          | 1.3          | 3.2         | 0.2          |
|  4.6          | 1.5          | 3.1         | 0.2          |
|---------------+--------------+-------------+--------------|
vagrant@data-science-toolbox:~/book/ch05$ <data/iris.csv csvcut -C species | head -n 5 | csvlook
|---------------+-------------+--------------+--------------|
|  sepal_length | sepal_width | petal_length | petal_width  |
|---------------+-------------+--------------+--------------|
|  5.1          | 3.5         | 1.4          | 0.2          |
|  4.9          | 3.0         | 1.4          | 0.2          |
|  4.7          | 3.2         | 1.3          | 0.2          |
|  4.6          | 3.1         | 1.5          | 0.2          |
```
重新对列排序，选择列：
csvcut -c 选择的列
csvcut -C 不选的列
Cut -d,(分割符是逗号） -f 1，3，5（选择第1，3，5列）
```shell
vagrant@data-science-toolbox:~$ echo -e 'a,b,c,d\n1,2,3,4' >a.csv
vagrant@data-science-toolbox:~$ csvlook a.csv
|----+---+---+----|
|  a | b | c | d  |
|----+---+---+----|
|  1 | 2 | 3 | 4  |
|----+---+---+----|
vagrant@data-science-toolbox:~/book/ch05/data$ echo -e 'a,b,c,d,e,f,g,h,i\n1,2,3,4,5,6,7,8,9' | csvcut -c $(seq 1 2 9|paste -sd,) |csvlook
|----+---+---+---+----|
|  a | c | e | g | i  |
|----+---+---+---+----|
|  1 | 3 | 5 | 7 | 9  |
|----+---+---+---+----|
vagrant@data-science-toolbox:~/book/ch05/data$ seq 1 2 9 | paste -sd,
1,3,5,7,9
vagrant@data-science-toolbox:~/book/ch05/data$ echo -e 'a,b,c,d,e,f,g,h,i\n1,2,3,4,5,6,7,8,9' | cut -d, -f 5,1,3
a,c,e
1,3,5
```
Echo -e 转义符号才有用，愁人。
https://segmentfault.com/q/1010000000730025
seq 1 2 9  从1开始，等差数列，最大值不超过9
Paste -s 练成一行（而不是一列），d分割符号，后面逗号（分割符是逗号）。
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < iris.csv csvsql --query "SELECT sepal_length, petal_length, sepal_width, petal_width FROM stdin" | head -n 5 | csvlook
|---------------+--------------+-------------+--------------|
|  sepal_length | petal_length | sepal_width | petal_width  |
|---------------+--------------+-------------+--------------|
|  5.1          | 1.4          | 3.5         | 0.2          |
|  4.9          | 1.4          | 3.0         | 0.2          |
|  4.7          | 1.3          | 3.2         | 0.2          |
|  4.6          | 1.5          | 3.1         | 0.2          |
|---------------+--------------+-------------+--------------|
```
Csvsql --query  (from stdin) 对csv文件进行sql查询。

Filtering Lines
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ seq 5 | sed -n '3,5p'
3
4
5
vagrant@data-science-toolbox:~/book/ch05/data$ seq 5 | header -a count
count
1
2
3
4
5
vagrant@data-science-toolbox:~/book/ch05/data$ seq 5 | header -a count | body sed -n '3,5p'
count
3
4
5
vagrant@data-science-toolbox:~/book/ch05/data$ seq 5 | header -a count | sed -n '3,5p'
2
3
4
vagrant@data-science-toolbox:~/book/ch05/data$ < tips.csv head -n 5 |csvlook
|--------+------+--------+--------+-----+--------+-------|
|  bill  | tip  | sex    | smoker | day | time   | size  |
|--------+------+--------+--------+-----+--------+-------|
|  16.99 | 1.01 | Female | No     | Sun | Dinner | 2     |
|  10.34 | 1.66 | Male   | No     | Sun | Dinner | 3     |
|  21.01 | 3.5  | Male   | No     | Sun | Dinner | 3     |
|  23.68 | 3.31 | Male   | No     | Sun | Dinner | 2     |
|--------+------+--------+--------+-----+--------+-------|

vagrant@data-science-toolbox:~/book/ch05/data$ csvgrep -c size -i -r'[1-4]' tips.csv | csvlook
|--------+------+--------+--------+------+--------+-------|
|  bill  | tip  | sex    | smoker | day  | time   | size  |
|--------+------+--------+--------+------+--------+-------|
|  29.8  | 4.2  | Female | No     | Thur | Lunch  | 6     |
|  34.3  | 6.7  | Male   | No     | Thur | Lunch  | 6     |
|  41.19 | 5.0  | Male   | No     | Thur | Lunch  | 5     |
|  27.05 | 5.0  | Female | No     | Thur | Lunch  | 6     |
|  29.85 | 5.14 | Female | No     | Sun  | Dinner | 5     |
|  48.17 | 5.0  | Male   | No     | Sun  | Dinner | 6     |
|  20.69 | 5.0  | Male   | No     | Sun  | Dinner | 5     |
|  30.46 | 2.0  | Male   | Yes    | Sun  | Dinner | 5     |
|  28.15 | 3.0  | Male   | Yes    | Sat  | Dinner | 5     |
|--------+------+--------+--------+------+--------+-------|
```
Header -a 加列名
body sed -n 只从body中选（不包括首行）
csvgrep -c c是列的意思。
Csvgrep -i 不选
Csvgrep -r 正则表达式匹配
命令行工具的参数顺序没关系
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < tips.csv awk -F, '($1 > 40.0) && ($5 ~ /S/)' | header -a 'bill,tip,sex,smoker,day,time,size' | csvlook
|--------+------+--------+--------+-----+--------+-------|
|  bill  | tip  | sex    | smoker | day | time   | size  |
|--------+------+--------+--------+-----+--------+-------|
|  48.27 | 6.73 | Male   | No     | Sat | Dinner | 4     |
|  44.3  | 2.5  | Female | Yes    | Sat | Dinner | 3     |
|  48.17 | 5.0  | Male   | No     | Sun | Dinner | 6     |
|  50.81 | 10.0 | Male   | Yes    | Sat | Dinner | 3     |
|  45.35 | 3.5  | Male   | Yes    | Sun | Dinner | 3     |
|  40.55 | 3.0  | Male   | Yes    | Sun | Dinner | 2     |
|  48.33 | 9.0  | Male   | No     | Sat | Dinner | 4     |
|--------+------+--------+--------+-----+--------+-------|
vagrant@data-science-toolbox:~/book/ch05/data$ < tips.csv csvsql --query "SELECT * FROM stdin WHERE bill >40 AND day LIKE '%S%'" | csvlook
|--------+------+--------+--------+-----+--------+-------|
|  bill  | tip  | sex    | smoker | day | time   | size  |
|--------+------+--------+--------+-----+--------+-------|
|  48.27 | 6.73 | Male   | 0      | Sat | Dinner | 4     |
|  44.3  | 2.5  | Female | 1      | Sat | Dinner | 3     |
|  48.17 | 5.0  | Male   | 0      | Sun | Dinner | 6     |
|  50.81 | 10.0 | Male   | 1      | Sat | Dinner | 3     |
|  45.35 | 3.5  | Male   | 1      | Sun | Dinner | 3     |
|  40.55 | 3.0  | Male   | 1      | Sun | Dinner | 2     |
|  48.33 | 9.0  | Male   | 0      | Sat | Dinner | 4     |
```
Awk 筛选，-F（field）逗号分隔符，第一列大于40，而且，第五列是S开头的。
Sql中like只有两个字符号，%（无限个字符）和_（一个字符）。

Merging Columns
```shell
vagrant@data-science-toolbox:~/book/ch05/data$ < names.csv head -n 5 |csvlook
|-----+-----------+------------+-------|
|  id | last_name | first_name | born  |
|-----+-----------+------------+-------|
|  1  | Williams  | John       | 1932  |
|  2  | Elfman    | Danny      | 1953  |
|  3  | Horner    | James      | 1953  |
|  4  | Shore     | Howard     | 1946  |
|-----+-----------+------------+-------|
agrant@data-science-toolbox:~/book/ch05/data$ < names.csv sed -re '1s/.*/id,full_name,born/g;2,$s/(.*),(.*),(.*),(.*)/\1,\3 \2,\4/g' |csvlook
|-----+---------------+-------|
|  id | full_name     | born  |
|-----+---------------+-------|
|  1  | John Williams | 1932  |
|  2  | Danny Elfman  | 1953  |
|  3  | James Horner  | 1953  |
|  4  | Howard Shore  | 1946  |
|  5  | Hans Zimmer   | 1957  |
vagrant@data-science-toolbox:~/book/ch05/data$ < names.csv awk -F, 'BEGIN{OFS=",";print "id,full_name,born"}{if(NR>1) {print $1,$3" "$2,$4}}' |csvlook
|-----+---------------+-------|
|  id | full_name     | born  |
|-----+---------------+-------|
|  1  | John Williams | 1932  |
|  2  | Danny Elfman  | 1953  |
|  3  | James Horner  | 1953  |
|  4  | Howard Shore  | 1946  |
|  5  | Hans Zimmer   | 1957  |
vagrant@data-science-toolbox:~/book/ch05/data$ < names.csv cols -c first_name,last_name tr \",\" \" \" | header -r full_name,id,born | csvcut -c id,full_name,born | csvlook
|-----+---------------+-------|
|  id | full_name     | born  |
|-----+---------------+-------|
|  1  | John Williams | 1932  |
|  2  | Danny Elfman  | 1953  |
|  3  | James Horner  | 1953  |
|  4  | Howard Shore  | 1946  |
|  5  | Hans Zimmer   | 1957  |
vagrant@data-science-toolbox:~/book/ch05/data$ <names.csv csvsql --query "SELECT id, first_name || ' '||last_name AS full_name, born FROM stdin" | csvlook
|-----+---------------+-------|
|  id | full_name     | born  |
|-----+---------------+-------|
|  1  | John Williams | 1932  |
|  2  | Danny Elfman  | 1953  |
|  3  | James Horner  | 1953  |
|  4  | Howard Shore  | 1946  |
|  5  | Hans Zimmer   | 1957  |
|-----+---------------+-------|
```
sed -re -r是正则表达式的通知 -e是替换的表达式
分号连接了需要替换的两部分：
1s/.*/id,full_name,born/g ：1表示header（不知道是不是只表示header还是第一部分）开头的s和g表示替换。.*表示全部内容。／／是重要的分开4部分的符号。
2,$s/(.*),(.*),(.*),(.*)/\1,\3 \2,\4/g ：2表示第二部分，逗号表示后面的分割符是逗号，$表示后面的数字都是$1第一列、第二列（参数），sg代表全局替换，/(.*),(.*),(.*),(.*)/表示待替换内容(括号代表分组）和后面的1 2 3 4分组，/\1,\3 \2,\4/替换内容\1表示转义为$1.
Awk 注意是单引号里面都是双引号，BEGIN是一个表达式，OFS分割符，if也是表达式
Cols -c 选择列（c-columns）
tr \",\" \" \" 。tr后面两部分，空格连接，第一部分\",\" 代表原表格形式（first_name,last_name) ,第二部分 \" \" 表示转换成的格式，fisrt_name last_name/ （“代表内容）

Combining Multiple CSV files
 
Concatenate vertically 按行连接
````shell
vagrant@data-science-toolbox:~/book/ch05/data$ < iris.csv fieldsplit -d, -k -F species -p . -s .csv
vagrant@data-science-toolbox:~/book/ch05/data$ ls
countries,csv   Iris-setosa.csv      table.html
countries.csv   Iris-versicolor.csv  table.json
countries.json  Iris-virginica.csv   test
vagrant@data-science-toolbox:~/book/ch05/data$ wc -l Iris-*.csv
 102 Iris-setosa.csv
 102 Iris-versicolor.csv
 102 Iris-virginica.csv
 306 total
```

fieldsplit 按照列分开。也就是按speices的不同分成几个文件。
-d, 逗号是分割符
-k  是不是保持列名
-F 列名（分类的列名）
-p 目录，分开以后的文件放在哪里
-s （suffix后缀）