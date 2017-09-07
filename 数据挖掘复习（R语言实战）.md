## 统计学

[TOC]

## 数据预处理

### 1. 数据挖掘引导

**数据准备：**

1. 获取数据（合并数据、处理遗漏、清洗脏数据）
2. 数据选择（相关数据，不同模式数据转换和数据的统一和汇总）
3. 数据预处理（检查数据完整性和一致性，消除噪音，编码数据）

**数据挖掘：**

1. 确定挖掘目标：确定要发现的知识类型
2. 选择算法
3. 数据挖掘：获得知识

**数据挖掘方法：**

1. 分类：预测模型通过某些数据得到另外的数据。（分类：离散变量；回归：连续变量）

   决策树、朴素贝叶斯、逻辑回归、神经网络

2. 聚类：从数据集中找出相似的数据并组成不同的组。（聚类没有明显确定的目标变量作为数据的属性）

   统计分析方法：距离。欧氏距离、海明距离。k-Means算法、分层凝聚法（Hierarchical Agglomerative Methods）、估计最大值法（Estimation Maximization）等

   机器学习方法：概念聚类。

   神经网络算法：ART模型、Kohonen模型。

3. 关联：发现知识，若两个或多个数据项的取值之间重复出现且概率很高，寻找数据子集间关系和数据之间的派生关系。

4. 预测：利用历史数据找出变化规律，建立模型，并用模型来预测未来数据的种类、特征等。

**数据挖掘算法：**

1. C4.5 分类决策树算法。信息论，对大量样本的属性进行分析和归纳，在树的每个节点上使用信息增益来度量选择分测试属性。
2. K-Means分类算法。距离。
3. SVM算法（support Vector Machine，支持向量机），监督学习。将向量映射到更高维度的空间里，在每个空间建立一个最大间隔超平面。在分开数据的超平面两边建有两个互相平行的超平面，分隔超平面使两个平行超平面的距离最大化。假定平行超平面间的距离或间距最大，分类器的总误差越小。
4. Apriori关联分析算法。挖掘布尔关联规则频繁项集。
5. EM（Expectation-Maximization，最大期望）算法，概率模型中寻找参数最大似然估计的算法。（？类似最小二乘的回归估计）
6. PageRank算法，根据网站的外部链接和内部链接的数量和质量，衡量网站的价值。每个到页面的链接都是对该page的一次投票，被链接的越多，就意味着被其他网站投票越多。
7. AdaBoost算法，针对同一个训练集训练不同的分类器（弱分类器），然后把这些弱分类器集合起来，构成一个更强的最终分类器（强分类器）。改变数据分布。
8. kNN算法（k-Nearest Neighbor，K最近邻）分类算法，模式识别统计学算法。
9. 朴素贝叶斯算法（Naive Bayesian Model，NBC），学习结果是对不同可能的信任程度。
10. CART算法（Classification Regression Trees，分类回归树），非参数分类和回归方法，构建二叉树。

### 2. 数据概览

####列联表（contingency Table）：

行：rows，观测点obsevations，样本数

列：columns， 变量variables

维度：dimension 行*列

#### 数据分类

按数据的计算性：

定量数据Quantitative Data： 连续型数据Continuous Data 和离散型数据 Discrete Data（在数据区间极大的情况下，连续和离散数据没有区别的必要）

定性数据Qualitative Data：定类数据、定序数据、定距数据、定比数据。

按R的数据类型：

numeric数值型：定量数据

integer整数型

logical逻辑型 

character／string 字符型

factor 因子型（披着定量数据外壳的定型数据，表述）

#### R简单的数据处理

获得基本信息：

```R 
library(MASS)
data(Insurance)  # get data
a = Insurance
dim(a)  # dimension
names(a) # column names
head(a) # head rows
tail(a) # tail rows
class(a$District) # 数据类型
levels(a$Distct)  # 获得因子值
is.numeric(a) # 判断是否是数值型
is.integer(a)
is.logical()
is.character()
as.numeric(a) # 变成数值型
nchar() #character的字符数
nrow()
ncol()
length()
```

抽样：

简单抽样：sample(x, size, replace = FALSE, prob = NULL)

x-带抽取对象，size-抽多少，replace（F无放回，T放回），prob各个抽样样本的抽样概率，默认无取值（等概率抽样）

分层抽样：strata

strata(data, stratanames = NULL, size, method = c('srswor','srswr','poison','systematic'),pik, description = FALSE)

stratanames:设置层的data的变量名（某一列）。method中，'srswor'无放回,'srswr'无放回,'poison'泊松,'systematic'系统抽样。pik各层的概率。description是否输出含有各层信息的结果。

返回值是抽出来的位置，用getdata（原data，strata的返回值）获得样本集合。

整群抽样：cluster

cluster(data, cluster name, size, method, pik ,description)

Cluster name 是划分群的变量的名称

### 3. 获取数据

内置数据集、包的数据集

Csv,txt： read.csv().    Read.table(). write.csv().   write.table(). 区别就是分隔符

EXCEL ：Windows {RODBC}

```R
library(RODBC)
channel = odbcConnectExcel(file.choose()) # path is ok
channel # get the info
sqlTables(channel) #get the sheet name
data1 = sqlFetch(channel, 'Sheet1')
```

Mac: {gdata} read.xls

```R
xlsfile = file.path(path.package('gdata','xls','iris.xls'))
iris = read.xls(xlsfile)

```

数据库：

需要先在电脑上设置database的数据源（ODBC）也就是下面dsn的名称，userid，password

```r
library(RODBC)
odbcDataSources() # get the accessable databases
channel = odbcConnect(dsn, uid=' ', pwd = '  ') # connect to a database
sqlFetch(channel, sqltable) # get the table
sqlQuery(channel, query) # get the query
sqlsave(channel, mydf, tablename, = sqltable, append = FALSE) #update or append to the database
sqlDrop(channel, sqtable) # delete a table
sqlClear(channel, sqltable) # delete content from a table
sqlTables(channel) # get info of tables
sqlColumns(channel, sqtable) # get info of a table
close(channel) # close connection

```

网页信息：

```R
library(XML)
url = 'http://...'
table = readHTMLTable(url)
```

### 4. 探索性数据分析

数字化+可视化

数据集探索：行数nrow，列数ncol，维度dim，个别行观察head

####数字化探索

数据的整体结构、变量情况、分布指标、缺失值等

变量概况：

attributes() 列属性

str() 内部结构：观测样本数、变量数、变量类型和取值。

summary() 统计：定性变量的取值频数，定量变量的各个分位数。

还有一些其他的包的函数，主要统计指标有：

数值型变量：均值、方差、标准差、峰度、偏度、95%致信水平下置信的下限、上限（LCL mean 和UCL mean）

定性变量：频数



分布指标：数据集中各变量各水平的取值情况。

离散变量：二项分布、泊松分布、几何分布等。

连续变量：均匀分布、指数分布、正态分布等。

分布的展示方式：直方图、概率密度曲线。

```
x # 一个数值型数据的序列
mean()
sd()
var()
quantile()
library(timeDate)
skewness(x)
kurtosis(x)
```

**稀疏型：**针对高维数据，当数据集中的变量个数很大，但其中的大部分变量仅有小部分样本有取值。{Matrix}包的函数处理高密度矩阵或稀疏矩阵。（不太懂）

**缺失值：**	{mice} 的md.pattern（）获得缺失值分布。多重查补技术（Multiple Imputation）。

第一列代表数量，带列名的列显示0代表有NA值，最后一列代表这一个样本中有几个变量缺失，最后一行代表这个属性有几个NA。

|      | Age  | Holders | Claims | Group | District |      |
| ---- | ---- | ------- | ------ | ----- | -------- | ---- |
| 45   | 1    | 1       | 1      | 1     | 1        | 0    |
| 11   | 1    | 1       | 1      | 1     | 0        | 1    |
| 4    | 1    | 1       | 1      | 0     | 1        | 1    |
| 4    | 1    | 1       | 1      | 0     | 0        | 2    |
|      | 0    | 0       | 0      | 8     | 15       | 23   |

sum(is.na(data)). # 计算na的数量

sum(complete.cases(data)) #data中完整的数量

相关性**：cor() 一般而言，相关系数的绝对值高于0.75认为相关性比较高了，但要考虑具体问题。

#### 可视化探索

（x代表单变量（定性数据，计数）

下面的大部分图都支持两个变量的分组

直方图：反映分布情况，频数或频率，+密度曲线。hist（x）+ lines（density（x））

累计分布图：分布.{Himcs}Ecdf（x）

箱型图：分布（分位点、异常点）

小提琴图（比例箱型图）：{Himsc} bpplot 

条形图：离散型数据的按数值分组的频数图。barplot（）+legend（）图例

点阵图：和条形图作用相同，显示离散型变量个取值水平，用点和背景网格线的形式代替条形表示。

饼图：pie（）

### 5. 数据预处理

#### 加载数据集

#### 可视化探索

#### 处理缺失值

查看缺失值

```R
library(mice)
libarary(MASS)
data(nhanes2)
sum(is.na(nhanes2))
sum(complete.cases(nhanes2))
md.pattern(nhanes2)
```

如果想建立回归模型，但是因为有缺失值，且这个数据很小如果删除了含有NA的样本，就无法建立回归模型，这样用mice函数以后可以建立回归模型。

mice函数：生成m个完整的数据集。

Lm：用mice函数返回的数据集回归。

pool：汇总上面的多个数据集的回归模型。

多重插补法（multivariate imputation）：通过变量间的关系对缺失数据进行预测，==利用蒙特卡洛方法生成多个完成的数据集==，再对这些数据集分别进行分析，最后对分析。结果进行汇总处理。

```R
> summary(nhanes2)
    age          bmi          hyp          chl       
 20-39:12   Min.   :20.40   no  :13   Min.   :113.0  
 40-59: 7   1st Qu.:22.65   yes : 4   1st Qu.:185.0  
 60-99: 6   Median :26.75   NA's: 8   Median :187.0  
            Mean   :26.56             Mean   :191.4  
            3rd Qu.:28.93             3rd Qu.:212.0  
            Max.   :35.30             Max.   :284.0  
            NA's   :9                 NA's   :10     > imp = mice(nhanes2, m =4)

 iter imp variable
  1   1  bmi  hyp  chl
  1   2  bmi  hyp  chl
  1   3  bmi  hyp  chl
  1   4  bmi  hyp  chl
  2   1  bmi  hyp  chl
  2   2  bmi  hyp  chl
  2   3  bmi  hyp  chl
  2   4  bmi  hyp  chl
  3   1  bmi  hyp  chl
  3   2  bmi  hyp  chl
  3   3  bmi  hyp  chl
  3   4  bmi  hyp  chl
  4   1  bmi  hyp  chl
  4   2  bmi  hyp  chl
  4   3  bmi  hyp  chl
  4   4  bmi  hyp  chl
  5   1  bmi  hyp  chl
  5   2  bmi  hyp  chl
  5   3  bmi  hyp  chl
  5   4  bmi  hyp  chl

> fit = with(imp, lm(chl~age+hyp+bmi))
> pooled=pool(fit)
> summary(pooled)
                  est        se         t        df
(Intercept) 20.189117 64.745941 0.3118206 12.684141
age2        46.512610 28.684279 1.6215366  5.116302
age3        66.032309 32.481454 2.0329234  4.694955
hyp2         2.886032 23.633649 0.1221154  6.533996
bmi          5.324098  2.148956 2.4775280 13.991232
              Pr(>|t|)        lo 95     hi 95 nmis
(Intercept) 0.76024313 -120.0408849 160.41912   NA
age2        0.16450206  -26.7213793 119.74660   NA
age3        0.10141959  -19.1223306 151.18695   NA
hyp2        0.90647785  -53.8168823  59.58895   NA
bmi         0.02660484    0.7147753   9.93342    9
                  fmi    lambda
(Intercept) 0.2899322 0.1861526
age2        0.6267281 0.5046700
age3        0.6556383 0.5347027
hyp2        0.5413639 0.4196128
bmi         0.2477667 0.1474102
# nmis：变量中的缺失数据个数，fmi：fracion of missing information，由缺失数据贡献的变异。
```

缺失值的处理方法：

1. 删除法：当删除以后不影响数据结构。
   - 删除样本
   - 删除变量
   - 删除数据以后改变权重。
2. 插补法

- 单变量插补

  - 均值插补  which(is.na(x)) = mean(x)


  - 回归插补 

    ```R
    re = lm(chl~age, data = nhanses)
    y = round(predict(re, x[is.na(x)]))
    x[is.na(x)] = y
    ```

    ​

  - 二阶插补

  - 热平台插补

  - 冷平台插补

  - 抽样插补

- 多变量插补

#### 噪声数据处理

噪声：一个测量变量中的随机错误或偏差，包括错误值或偏离期望的孤立点值。{outliers} outlier: 通过查找数据集中与其他观测值及均值差距最大的点作为异常值。

噪声，简言之，离群点。

找噪声：outlier(x, opposite = FALSE, logical = FALSE)

光滑数据：去掉噪声。（分箱、回归、计算及检查、人工检查）

- 分箱：对数据排序，利用数据近邻来光滑有序数据值的局部光滑方法。
- 回归：通过一个函数来你和对数据进行光滑。简单线性回归、多元线性回归。

#### 数据不一致的处理

比如编码不一致，比如需要3位数，出现了4位数等。

FUN.VALUE可以设置返回值的长度和类型，如果不一致会报错。

```R
rt.value = c(0,0,0)
vapply(x, quantile, FUN.VALUE = rt.value, probs = probs)
```

| **两个序列是否相关** | **卡方检验** | **chisq.test()** | **p_value<0.05 ****序列不相关** |
| ------------ | -------- | ---------------- | -------------------------- |
| 两个序列是否相关     | 相关系数     | cor              |                            |
| 两个序列是否相关     | 协方差      | cov              |                            |



#### 数据变换

1. 光滑：去掉噪声。分箱、回归、聚类等技术。讲噪声替换为正常值。
2. 属性构造：由给定属性创建出新属性。简单变换，如将销售额和成本创造出利润。
3. 聚集：汇总数据。比如，按固定时间周期。
4. 规范化：把数据进行按比例缩放。如scale（）
5. 离散化：将定量数据转化为定性数据，将连续性数据离散化。比如年龄分为少年、中年。
6. 由标称数据产生概念分层：属性。比如将沈阳、大连数据泛化为辽宁省。

#### 数据规约

目的：压缩数据量，但保持原数据等特征。

方法：维归约，数值归约。

维归约：减少属性的方式压缩数据量，通过一处不相关的属性，可以提高模型效率。AIC准备可以通过选择最优模型来选择属性。LASSO通过一定约束条件选择变量。分类树、随即森林通过对分类效果的影响大小筛选属性。小波变换、主成分分析通过吧原数据变换投影到较小的空间来降低维度。

AIC准则（赤池信息准则），用来评价模型的复杂度和你和效果。

AIC=-2ln(L)+2k

L：似然函数，代表模型的精确度，k为参数的数量，代表模型的准确度。L越大，拟合越好，k越小，模型越简洁。AIC兼顾了模型的精确度和间接性。AIC最小为最有。

数值归约：用较小的数据表现形式替换原数据。

## 中篇 基本算法

学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

### 6. 关联分析

学习目标：

- 用途：从大量数据中发现项集之间的关联或者相互关系。

- 算法：Apriori

- 基本原理：

  项集（Itemset）：一篮子商品中的各种消费品的组合。一种就是一项item。一项中有两个商品称为二元项集。

  关联规则（Association Rule）：x➡️y。x先决条件，y关联结果，表示数据的关联性。如尿布➡️啤酒

  支持度（support）。所有项集中{X,Y}出现的概率。衡量“量”的多少，最小阈值（minsup，Minimun Support），低于最小阈值来提出出镜率无意义的规则。满足条件称为频繁项集（Frequent Itemset）

  置信度（Confidence）：关联规则的先决条件X发生条件下，关联结果Y发生的概率。条件概率P(Y|X) =P(X,Y)/P(X) = P(XY)/P(X)。衡量“质”的可靠性。最小阈值（mincon， Minimum Confidence），筛选出强关联规则。

  提升度（lift）：含有X条件下，同时含有Y的可能性与没有这个条件下项集含有Y的可能性纸币，即在Y自身出现可能性P(Y)的基础上，X的出现对Y的出镜率P(Y|X)的提升影响。lift(X➡️Y)=P(Y|X)/P(Y)。衡量规则的可靠性。置信度的互补指标。越大越好。

- R操作

  {arules} {arulesViz}

  Apriori

  Eclat

  ```R
  #install.packages('arules')
  library(arules)
  #data(Adult) # 很多数据都需要载入
  #example("apriori") # 可以看这个函数的例子
  data("Groceries") # 载入数据，关联规则的数据很特别
  summary(Groceries)
  inspect(Groceries[1:10]) # 看前10条数据
  rule0 = apriori(Groceries, parameter = list(support = 0.001, confidence = 0.5))
  rule0
  inspect(rule0[1:10]) # 看前10条规则
  rule0_sort = sort(rule0, by = 'support') # sort by support,也可以是置信度和提升度confidence，lift
  inspect(rule0_sort[1:10])
  rule0 = apriori(Groceries, parameter = list(supp = 0.001, confidence = 0.5, target = 'frequent itemsets'), control = list(sort=-1))
  # 目标参数：频繁项集，并按频繁项集降序排序。
  # 可视化
  #install.packages('arulesViz')
  library(arulesViz)
  plot(rule0)
  plot(rule0,interactive = T) # 可以交互。此外，这里画图还有参数，可以研究下。
  ```

- 数学原理

  1. 先计算满足最小支持度的所有项集，成为频繁项集
  2. 从频繁项集中找出满足最小置信度的所有规则。

- 算法优化点

### 7. 聚类分析

学习目标：

- 用途：把若干事物按照某种标准归为几个类别，其中较为相近的聚为一类，不那么相近的聚于不同类。

- 基本算法

- K-Means均值

  K-Medoids中心点聚类

  密度距离（Densit-based Spatial Clustering of Application with Noise, DBSCAN)

  系谱聚类（Hierachical Clustering， HC）

  期望最大化聚类（Expectation Maximazation，EM）

K-均值聚类

- 基本算法：随机选取k个样本作为起始中心点，将其余样本归入相似度最高中心点所在点簇（cluster），再确立当前簇中样本坐标的均值作为新的中心点，一次循环迭代下去，直到所有样本所属类别不再变动。

- R操作

  {stats} kmeans()

  kmeans(x, centers, iter.max = 10, nstart =1, algorithm)

  x=data, centers = k, iter.max 迭代次数，nstart选择随机起始中心点的次数。算法。

```R
result = kmeans(data, 2) # data是没有标签的，只有数值型变量的
data$cluster = result$cluster # 将组号写在data里面。
```



- 数学原理
- 算法优化点：快，对异常值或极值点敏感，稳定性差，适合处理分布集中的大样本数据集。

K-中心点聚类
- 基本算法：和K-均值类似，区别是新的中心点不是军职，而是取其余样本距离之和最小的样本作为中心。

- R操作

  {cluster} pam()

  pam(data,k)

  ```R
  library(cluster)
  fit_pam = pam(life,3)  # 分组3
  ```

- 数学原理

- 算法优化点：改进K-均值受极值点影响。

系谱聚类
- 基本算法：聚类的过程类似于系谱图，不需要事先识丁类别，因为他每次迭代过程中仅将距离最近的两个样本和簇聚在一类。

- R操作

  {stats} hclust. cutree. rect.hclust()

  tree = hclust(距离)

  cutree(tree,k,h) #剪枝，选择输出置顶类别数的系谱聚类结果。

  rect.hclust(tree) # 图展示

  ```r
  fit_hc = hclust(dist(life)) # dist计算欧式距离
  group = cutree(fit_hc, k=3) #k是组数量，h是高度
  plot(fit_hc) # 画图谱系图
  rect.hclust(fit_hc, k = 3) # 画图谱系图+分组识别（因为是stats包，plot可以泛式函数，直接动用）
  ```

- 数学原理

- 算法优化点：不需要实现设定类别数k。

密度聚类（Density-based Methods）
- 基本算法

- R操作

  {fpc} dbscan()

  dbscan(data, eps, MinPts) #eps是邻域的半径。MinPts 密度阈值

  ```R
  > library(fpc)
  > ds = dbscan(life, eps = 1, MinPts = 5)
  Error in data - x : 二进列运算符中有非数值参数 # 报错，以后再去查原因吧。
  ```

- 数学原理

- 算法优化点：基于密度来聚类，可以在具有噪声低空间数据库中发现任意形状的簇。


期望最大化聚类（EM）


- 基本算法：将数据集看作一个含有隐形变量的概率模型，并以实现模型最优化，即获取与数据本身性质最契合的聚类方式为目的，通过“反复估计”模型参数找到最优解，同时给出相应的最优类别数k。“反复估计”的过程是EM算法的精华，由E-step（expectation）和M-step（Maximization）。

- R操作

  {mclust} Mclust() clustBIC()  mclust2Dplot() densityMclust()

  ```R
  library(mclust)
  fit_em = Mclust(life)
  plot(fit_em)   #可以直接画图，就是单位不同
  ```

  ​

- 数学原理

- 算法优化点


### 8. 判别分析

学习目标：

- 用途：判断样本所属的类别，依据是那些已知类别样本的属性信息。

- 算法：费希尔判别Fisher、贝叶斯判别Bayes、距离判别

  费希尔判别：线性判别分析Linear Discriminant Analysis（LDA）、二次判别分析Quadratic Discriminant Analysis（QDA）

  贝叶斯判别：朴素贝叶斯分类Naive Bayesian Classification算法

  距离判别：K最近邻k-Nearest Beighbor（kNN）、有权重的ZK最近邻（Weighted k-Nearest Neighbor）算法。

- 基本原理

  费希尔判别：投影，将高维空间的点向低维空间投影。在原坐标系下，空间中的点可能很难划分开。总重要的是选择适当的投影轴，要求是保证投影后，使每一类之内的投影所形成的类内离差尽可能小，而不同类之间的投影值所形成的类间离差尽可能大，即在该空间有最佳的可分离性，以此获得较高的判别效果。

  线性盘背：

- R操作

- 数学原理

- 算法优化点

### 9. 决策树

学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

## 下篇 高级算法

### 10. 集成学习

学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

### 11. 随机森林

学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

### 12. 支持向量机

学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

### 13. 神经网络学习目标：

- 用途
- 基本原理
- R操作
- 数学原理
- 算法优化点

### 14. 模型评估与选择







