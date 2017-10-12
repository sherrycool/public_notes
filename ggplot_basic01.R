library(ggplot2)
# data
library(titanic) # data titanic_train
library(faraway) # data worldcup, data nepali
library(dplyr)
# initialize a ggplot object
# object = ggplot(dataframe, ase(x = col1, y = col2))
# parameter inside aes
# x: x-axis
# y: y-axis
# shape : line or point shape
# color: color of border of elements, can also be used to group
# fill : color of inside of elements, can also be used to group
# size : size, bubble size
# alpha : transparency 0-1
# linetype: type of line(solid, dashed...)

# create a basic ggplot plot
ggplot()+
  geom_histogram(data = titanic_train, aes(x = Fare))
# or

titanic_train %>%
  ggplot() + geom_histogram(aes(x = Fare))

# geoms
ggplot(data = titanic_train, aes(x = Fare))+
  geom_histogram(bins = 35) # think about variables (single or two, what relationship you want to see)
ggplot(worldcup, aes(x = Time, y = Passes))+
  geom_point()
ggplot(worldcup, aes(x = Time, y = Passes, color = Position,
                     size = Shots)) +
  geom_point()
# different statistic pictures
# geom_point() x,y 散点图（数值型）
# geom_line() x,y | arrow,na.rm
# geom_segment() x,y, xend, yend | arrow,na.rm
# geom_path() x, y | na.rm
# geom_polygon() x,y
# geom_histogram() x | bins, binwidth 直方图（数值型）
# geom_abline() intercept, slope 辅助线图
# geom_hline() yintercept  垂直于横轴的垂线
# geom_vline() xintercept 平行与横轴的直线
# geom_smooth() x, y| method, se, span
# geom_text() x, y, label | parse, nudge_x, nudge_y 文字标注，两个data有一致的x和y，label标志内容。

# using multiple geoms
noteworthy_players = worldcup %>%
  filter(Shots == max(Shots) | Passes == max(Passes)) %>%
  mutate(point_label = paste(Team, Position, sep=','))

ggplot(data = worldcup, aes(x = Passes, y = Shots, color = Position))+
  geom_point()+
  geom_text(data = noteworthy_players, aes(label = point_label,
                                           vjust = 'inward',hjust = 'inward'))

ggplot(worldcup, aes(x = Time))+
  geom_histogram(binwidth = 10)+
  geom_vline(xintercept = 90*0:6,
             color = 'green', alpha = 0.6)

# constant aesthetics (color , shape, fill), refer to http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
ggplot(data = worldcup, aes(x = Time, y = Passes)) +
  geom_point(color = 'darkred') +
  ggtitle('Time and Passses of WorldCup')+
  labs(x = 'Time',y = 'Passs')+
  xlim(200,400)
# color : blue, blue4, darkorchid, deepskyblue2, stellblue1, dodgerblue3

# other useful plot addtions
# ggtitle: plot title
# xlab, ylab : x-axis, y-axis labels
# xlim, ylim : limits of x-axis, y-axis

nepali_1 = nepali %>%
  select(id, sex, wt, ht, age) %>%
  mutate(id = factor(id),
         sex = factor(sex, levels = c(1,2),
                      labels = c('Male','Female'))) %>%
  distinct(id, .keep_all = TRUE)
head(nepali_1)
# histogram
ggplot(nepali_1, aes(x= ht))+
  geom_histogram(binwidth = 2)

ggplot(nepali_1, aes(x = ht)) +
  geom_histogram(bins = 30, color = 'black', fill = 'lightblue') +
  ggtitle('Height of Chilren') +
  xlab('Hight (cm)') + xlim(c(40,120))
# scatterplots
ggplot(data = nepali_1, aes(x = ht, y = wt))+
  geom_point(color = 'red')

ggplot(data = nepali_1, aes(x = ht, y = wt))+
  geom_point(color = 'red', size = 1.5, alpha = 0.8) +
  ggtitle('Weight versus Height')+
  xlab('Height (cm)') + ylab('Weight (kg)')

ggplot(data = nepali_1, aes(x = ht, y = wt, color = sex))+
  geom_point(size = 0.5, alpha = 0.8) +
  ggtitle('Weight versus Height')+
  xlab('Height (cm)') + ylab('Weight (kg)')
# boxplot
ggplot(data = nepali_1, aes(x = 1, y = ht))+
  geom_boxplot() +
  xlab('') +ylab('Height (cm)')

ggplot(data = nepali_1, aes(x = sex, y = ht))+
  geom_boxplot() +
  ylab('Height (cm)')

library(GGally)
ggpairs(nepali_1 %>% select(sex, wt, ht, age))
# 有n个变量就是n*n维的图像，图像是1维或者二维的。单变量是分布（品质型：频数分布图，数值型
# :区域图）。双变量（品质-品质：分组频数分布图（两张），品质-数值：箱形图，分组茎叶图；
# 数值-数值：相关系数、散点图）
# 画图的时候注意将品质型转变为品质型、因子型。
a = nepali %>% mutate(id = factor(id), 
                      sex = factor(sex, levels = c(1,2), 
                                   labels = c('Male','Female')), 
                      died = factor(died, levels = c(0,1,2,3,4))) %>% select(id ,sex, died, wt, ht) %>% na.omit()
ggpairs(a %>% select(-id))



# Customizing ggplots2 plots
# Guildlines for data display:
# Aim for high data density.
# Use clear, meaningful labels.
# Provide useful references.
# Highlight interesting aspects of the data.
# Consider using small multiples.
# Make order meaningful.


library(dplyr)
library(ggplot2)
library(gridExtra)
library(ggthemes)
library(dlnm)
library(faraway)

data(nepali)
data(worldcup)
data(chicagoNMMAPS)
chic = chicagoNMMAPS
chic_july = chic %>% filter(month == 7 & year == 1995)
ggplot(data = chic_july, aes(x = date, y = death))+
  geom_line()
# change the theme of the plots: theme_bw()  theme_linedraw()  theme_minimal()  theme_void()  theme_dark()  theme_classic()
# an addition package called ggthemes, provide more themes, using the same way theme_tufte()  theme_few()
ggplot(data = worldcup, aes(x = Time, y = Shots)) +
  geom_point() +
  theme_economist()

chicago_plot = ggplot(data = chic_july, aes(x = date, y = death)) +
  geom_point() +
  xlab('Day in July 1995') +
  ylab('All-cause deaths') +
  ylim(0,450)

chicago_plot + geom_area(fill = 'black') +
  theme_excel()

chicago_plot + geom_line(color = 'red') +
  theme_tufte()

# make labels clearer
# xlab, ylab, scale(name), scale_x_continuous 
# tidyverse
# {scale} labels = percent
# coor_flip

library(forcats)
wc = worldcup %>%
  dplyr::rename(Pos = Position) %>%    # dplyr::rename 是因为basic函数有rename
  mutate(Pos = fct_recode(Pos,
                          'DC' = 'Defender',
                          'FW' = 'Forward',
                          'GK' = 'Goalkeeper',
                          'MF' = 'Midfielder'))  # fac_recode 是手动修改因子的值(品质型改名ß)
ggplot(data = wc, aes(x = Pos)) +
  geom_bar(fill = 'lightgray') +
  xlab('') +
  ylab('Number of players') +
  coord_flip() +
  theme_tufte()

ggplot(data = worldcup, aes(x = Position)) +
  geom_bar(fill = 'lightgray') +
  xlab('') +
  ylab('Number of players') +
  coord_flip() +
  theme_tufte()

# Provide useful references
# 标注合理区间和趋势 geom_smooth(): method(lm, glm), spam, se, level
# 其他辅助线：geom_hline, geom_vline, geom_abline, geom_polygon, geom_path
ggplot(filter(worldcup, Position == 'Forward') , aes(x = Passes, y = Shots)) +
  geom_point(size = 1.5)+
  theme_few() +
  geom_smooth() 

# highlighting
# geom_text, geom_line
chic_july %>%
  ggplot() +
  geom_line(aes(x = date, y = death))+
  geom_line(aes(x = date, y = temp, color = 'red'))

noteworthy_players = worldcup %>% 
  filter(Passes == max(Passes) | Shots == max(Shots)) %>%
  mutate(point_label = paste(Team, Position, sep = ','))

ggplot(data = worldcup)+
  geom_point(aes(x = Passes, y = Shots, color = Position))+
  geom_text(data = noteworthy_players, aes(x = Passes, y = Shots, label = point_label, 
                                           vjust = 'inward', hjust = 'inward', color = Position)) +
  theme_few()

# use small multiple
# USE faceting: facet_grid, facet_wrap.facet_grip(.~Team) facet_wrap(~Team)区别是grip只能放在一行，wrap能放在多行
# facet_grid(factor for rows可以省略 ~ factor for columns)
# facet_wrap(~[formula with factor(s) for faceting]和grid一样的，按什么分类, col = [number of columns]每一行放几个图)
worldcup %>%
  ggplot(aes(x = Time, y = Shots, color = Position)) +
  geom_point() +
  facet_grid(.~Position)+
  geom_smooth()+
  theme_few()

worldcup %>%
  filter(Team %in% c("Spain", "Netherlands")) %>%
  ggplot(aes(x = Time, y = Shots)) +
  geom_point()+
  facet_grid(Team ~ Position)

worldcup %>% 
  ggplot(aes(x = Time ,y = Shots)) +
  geom_point() +
  facet_wrap(~ Team, ncol = 7)

worldcup %>% 
  ggplot(aes(x = Time ,y = Shots)) +
  geom_point() +
  facet_grid(.~ Team)

nepali %>%
  mutate(sex = factor(sex, levels = c(1, 2), labels = c('Male','Female'))) %>%
  ggplot(aes(x = ht, y = wt))+
  geom_point() +
  facet_grid(.~sex) +
  ggtitle('Heights versus Weights (differenct genders)') +
  xlab('Height (cm)')+
  ylab('Weight (kg)') +
  theme_solarized()
# order by factors (catelogs)
nepali %>%
  mutate(sex = factor(sex, levels = c(2,1), labels = c('Female','Male'))) %>%
  ggplot(aes(x = ht, y = wt, color = sex))+
  geom_point() +
  facet_grid(.~sex) +
  ggtitle('Heights versus Weights (differenct genders)') +
  xlab('Height (cm)')+
  ylab('Weight (kg)') +
  theme_solarized()
# order by number
worldcup %>%
  group_by(Team) %>%
  summarise(meanTime = mean(Time)) %>%
  ggplot(aes(x = meanTime, y = Team)) +
  geom_point()

worldcup %>%
  group_by(Team) %>%
  summarise(meanTime = mean(Time)) %>%
  arrange(-meanTime) %>%
  ggplot(aes(x = meanTime, y = Team)) +
  geom_point()  # no use

worldcup %>%
  group_by(Team) %>%
  summarise(meanTime = mean(Time)) %>%
  arrange(meanTime) %>%  #
  mutate(Team = factor(Team, levels = Team)) %>%  #
  ggplot(aes(x = meanTime, y = Team)) +
  geom_point() +
  theme_few() +
  xlab('Mean time per player (minutes)') + ylab('')

# group & highlight
worldcup %>%  # 这个很cool
  select(Position, Time, Shots) %>%
  group_by(Position) %>%
  mutate(ave_shots = mean(Shots),
         most_shots = Shots == max(Shots))%>%  #mutate分组计算平均值和最高值，平均值用来排序，最大值用来标记
  #这里用的不是summarise就是不要汇总数据，只是分组计算
  # worldcup 每一条记录都是一个球员在此次世界杯的表现
  ungroup() %>%
  arrange(ave_shots) %>%
  mutate(Position = factor(Position, levels = unique(Position))) %>%
  ggplot(aes(x = Time, y = Shots, color = most_shots)) +
  geom_point(alpha = 0.5) +
  scale_color_manual(values = c('TRUE' = 'red','FALSE'='black'),
                     guide = F) +
  facet_grid(.~Position)+
  theme_few()

worldcup %>% # 每个team的球员都平均、最长和最短时间, 每个队员的上场时间，排序各个队伍的队员平均上场时间
  dplyr::select(Team ,Time) %>%
  group_by(Team) %>%
  mutate(minTime = min(Time), aveTime = mean(Time), maxTime = max(Time)) %>% # 生成每队的球员平均、最大、最小上场时间。
  arrange(aveTime) %>%  # 排序：每队的平均时间
  ungroup() %>% # 取消分组，如果不取消olumn `Team` can't be modified because it's a grouping variable
  mutate(Team = factor(Team, levels = unique(Team))) %>% # 将队伍变成一个因子变量
  ggplot(aes(x = Time, y = Team)) +
  geom_segment(aes(x = minTime, xend=maxTime, yend = Team), # 每队的球员上场时间的区间
               alpha = 0.5, color = 'gray')+
  geom_point(alpha = 0.5) + # 每组每个球员的上场时间
  geom_point(aes(x = aveTime), size = 2, color = 'red', alpha = 0.5) + # 每组平均上场时间
  theme_minimal()+
  ylab('')

## scaled  and color
# generic code: scale_[aestheict]_[vector_type]
# scale functions can be used to sed the name, breaks, labels, colors of plots legends.

ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) +
  geom_point(alpha = 0.5)+
  scale_x_continuous(name = 'Time played (minutes)',
                     breaks = 90 *c(2,4,6),
                     minor_breaks = 90 * c(1,3,5))  # x是连续型变量，用continuous，name， breaks，minor——breaks

ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) +
  geom_point(alpha = 0.5)+
  scale_x_continuous(name = 'Time played (minutes)',
                     breaks = 90 *c(2,4,6),
                     minor_breaks = 90 * c(1,3,5))  +
  scale_size_continuous(name = 'Shots on goal',
                        breaks = c(0,10,20)) # scale对应aes里面各个参数，continuous连续性变量
# name: label or legend name
# breaks: vector of break points
# minor_breaks: vector of minor break points
# labels: labels to use for each break
# limits : limits to range of the axis

ggplot(data = chic_july, aes(x = date, y = death)) +
  geom_line() +
  scale_x_date(name = 'Date in July 1995',
               date_labels = '%m-%d')  # change x to be date/datetime

ggplot(data = chic_july, aes(x = date, y = death)) +
  geom_line() +
  scale_y_log10(breaks = c(1:4*100))  # y变成log10显示：show plot with 'deaths' on a log scale

# 颜色 scale_color_hue, scale_color_manual, scale_color_gradient, scale_color_brewer, scale_color_distiller
# Brewer color palettes Brewer是一个有颜色信息，可以调用包RColorBrewer的display.brewer.pal函数看什么颜色
# 【链接】ColorBrewer:ColorAdviceforMaps    http://colorbrewer2.org/
  library(RColorBrewer)
display.brewer.pal(name = 'Set1', n = 8)
display.brewer.pal(name = 'PRGn', n = 8)
display.brewer.pal(name = 'PuBuGn', n = 8)

wc_example = ggplot(worldcup, aes(x = Time, y = Passes,
                                  color = Position, size = Shots)) +
  geom_point(alpha = 0.5)

a = wc_example +
  scale_color_brewer(palette = 'Set1') +ggtitle('Set1') + theme_few()
b = wc_example +
  scale_color_brewer(palette = 'Dark2') +ggtitle('Dark2')
c =wc_example +
  scale_color_brewer(palette = 'Accent') +ggtitle('Accent')
d = wc_example +
  scale_color_brewer(palette = 'Paste12') +ggtitle('Paste12') + theme_dark()
grid.arrange(a,b,c,d,ncol = 2)

# fill the color manually: scale_color_manual, scale_fill_manual
ggplot(worldcup, aes(x = Time, y = Passes, color = Position, size = Shots)) +
  geom_point(alpha = 0.5) +
  scale_color_manual(values = c('blue','red','darkgreen','darkgray'))

# 其他调色盘的包
# {viridis} : scale_color_viridis, scale_fill_viridis
library(viridis)
worldcup %>% ggplot(aes(x = Time, y = Shots, color = Passes)) +
  geom_point(size = 0.9) +
  #facet_wrap(~Position) +
  scale_color_viridis() # color是连续性变量

library(viridis)
worldcup %>% ggplot(aes(x = Time, y = Shots, color = Position)) +
  geom_point(size = 0.9) +
  scale_color_viridis(discrete = T) # COLOR是离散型变量

library(gridExtra)
# viridis options (A: Magma, B: Inferno, C:Plasma, D: Viridis)
worldcup_ex = worldcup %>% ggplot(aes(x = Time, y = Shots, color = Passes)) +
  geom_point(size = 0.9) 
magma_plot = worldcup_ex + scale_color_viridis(option = 'A') + ggtitle('magma')
inferno_plot = worldcup_ex + scale_color_viridis(option = 'B') + ggtitle('inferno')
plasma_plot = worldcup_ex + scale_color_viridis(option = 'C') + ggtitle('plasma')
viridis_plot = worldcup_ex + scale_color_viridis(option = 'D') + ggtitle('viridis')
grid.arrange(magma_plot, inferno_plot, plasma_plot, viridis_plot, ncol = 2)
# 其他可以参考的部分
#* R Graphics Cookbook by Winston Chang: This “cookbook” style book is a useful reference to have to flip through when you have a specific task you want to figure out how to do with ggplot2 (e.g., flip the coordinate axes, remove the figure legend).
#* http://www.cookbook-r.com/Graphs/: Also created by Winston Chang, this website goes with the R Graphics Cookbook and is an excellent reference for quickly finding out how to do something specific in ggplot2.
#* Google images: If you want to find example code for how to create a specific type of plot in R, try googling the name of the plot and “R”, and then search through the “Images” results. For example, if you wanted to plot a wind rose in R, google “wind rose r” and click on the “Images” tab. Often, the images that are returned will link back to a page that includes the example code to create the image (a blog post, for example).
#For more technical details about plotting in R, check out:
#  * ggplot2: Elegant Graphics for Data Analysis by Hadley Wickham: Now in its second edition, this book was written by the creator of grid graphics and goes deeply into the details of why ggplot2 was created and how to use it.
#* R Graphics by Paul Murrell: Also in its second edition, this book explains grid graphics, the graphics system that ggplot2 is built on. This course covers the basics of grid graphics in a later section to give you the tools to create your own ggplot2 extensions. However, if you want the full details on grid graphics, this book is where to find them.


# 4.3 mapping
library(ggplot2)

library(maps)
us_map = map_data('state')
head(us_map,3)
us_map %>% 
  filter(region %in% c('north caralina', 'south carolina')) %>%
  ggplot(aes(x = long, y = lat)) +
  geom_path()
us_map %>% 
  filter(region %in% c('north carolina', 'south carolina')) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_path()
# use geom_path rather than geom_line，因为line有顺序的连接起来，path是不连接重复的部分（outline），polygon多边形
# geom_polygon 可以填充颜色
us_map %>% 
  filter(region %in% c('north carolina', 'south carolina')) %>%
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'red', fill = 'lightblue') +
  theme_void()  # 不要坐标轴和背景

us_map %>% 
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'red', fill = 'lightblue') +
  theme_void()  # 不要坐标轴和背景
# choropleth 等值线图 复合到map上

data("votes.repub")
head(votes.repub)
a = votes.repub %>% # 是一个矩阵（各年度、各州大选投票）
      tbl_df() %>% # 将矩阵转化为tibble
      mutate(state = rownames(votes.repub),
                      state = tolower(state)) %>%
    right_join(us_map, by = c('state' = 'region'))  %>% select (state, long, lat,`1976`,group, order) %>% group_by(state) %>% summarise(long = head(long,1),lat = head(lat,1),`1976` = head(`1976`,1),group = head(group,1))
votes.repub %>% # 是一个矩阵（各年度、各州大选投票）
  tbl_df() %>% # 将矩阵转化为tibble
  mutate(state = rownames(votes.repub),
         state = tolower(state)) %>%
  right_join(us_map, by = c('state' = 'region')) %>%  #dplyr能实现join功能
  ggplot(aes(x = long, y = lat, group = group, fill =`1976`)) + #用1976年的数据填充的，因为R的列名不应该是数字，而且无法调用，所以用``这个符号调用
  geom_polygon(color = 'black') +
  theme_void() +
  geom_text(data = a,aes(x = long, y = lat, label = paste0(state,'\n',`1976`),vjust = 'inward',hjust = 'inward')) + # label这个是自己加的，间隙太小了，有困难。
  scale_fill_viridis(name = 'Republican\nvotes (%)') #legend显示内容
# 只要有各个区域的值（就可以）国内的一个包https://zhuanlan.zhihu.com/p/23247602（remap）

# {ggmap} google map
library(ggmap)
beijing = get_map('Beijing', zoom = 12) # 需要连vpn
ggmap(beijing) 
ggmap(beijing) + theme_void() +
  ggtitle('Beijing, China')

map_1 = get_map("Estes Park", zoom = 12,
                source = 'google', maptype = 'terrain') %>%
  ggmap(extent = 'device')

map_2 = get_map("Estes Park", zoom = 12,
                source = 'stamen', maptype = 'watercolor') %>%
  ggmap(extent = 'device')

map_3 = get_map("Estes Park", zoom = 12,
                source = 'google', maptype = 'hybrid') %>%
  ggmap(extent = 'device')

library(gridExtra)
grid.arrange(map_1,map_2, map_3, nrow = 1)

get_map(c(2.35, 48.86), zoom = 10) %>%  #获得地图的方式（地名、中心的经纬度，获得的是图片，）
  ggmap(extent = 'device')

# map这个先不学了，因为我们可以用remap包，练得是baidu-map api更好用的（针对中国和国内的网）
# htmlwidgets 画动态表格在web
library(plotly)
# plot_ly, plot_geo, plot_mapbax
plot_ly(worldcup, type = 'scatter', x = ~ Time, y = ~ Shots, color = ~ Position) #~ 代表动态
plot_ly(worldcup, type = 'scatter', x = ~ Time, y = ~ Shots, color = I('blue'))

worldcup %>%
  mutate(Name = rownames(worldcup)) %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
  add_markers(text = ~ Name, hoverinfo = 'text') # 每个点的显示信息是worldcup每个球员的名称

worldcup %>%
  mutate(Name = rownames(worldcup)) %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
  add_markers(text = ~ paste('<b>Name:</b> ',Name, "<br />",
                             "<b>Team:</b> ", Team), # html syntax :http://web.stanford.edu/group/csp/cs21/htmlcheatsheet.pdf
              hoverinfo = 'text') 

worldcup %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position) %>%
  add_markers()
# add_markder() add_lines()  add_paths() add_polygons() add_segments() add_histogram()

worldcup %>%
  plot_ly(x = ~ Time, y = ~ Shots, color = ~ Position,
          size = I(3)) %>%
  add_markers()

# draw 3-D picutres using data(volcano)
data("volcano")
class(volcano)
summary(volcano)
plot_ly(z = ~ volcano, type = 'surface')

# create a plot_ly plot using ggplot objects
worldcup_scatter = worldcup %>% 
  ggplot(aes(x = Time, y = Shots, color = Position)) + 
  geom_point()
ggplotly(worldcup_scatter)
# 4.4.3
