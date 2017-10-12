# ggplots

### Initializing a ggplot object

```R
library(ggplot2)
## Generic code
object <- ggplot(dataframe, aes(x = column_1, y = column_2))
## or, if you don't need to save the object
ggplot(dataframe, aes(x = column_1, y = column_2))
```

函数

| Function           | Common aesthetics        | Common arguments              |
| ------------------ | ------------------------ | ----------------------------- |
| `geom_point()`     | `x`, `y`                 |                               |
| `geom_line()`      | `x`, `y`                 | `arrow`, `na.rm`              |
| `geom_segment()`   | `x`, `y`, `xend`, `yend` | `arrow`, `na.rm`              |
| `geom_path()`      | `x`, `y`                 | `na.rm`                       |
| `geom_polygon()`   | `x`, `y`                 |                               |
| `geom_histogram()` | `x`                      | `bins`, `binwidth`            |
| `geom_abline()`    | `intercept`, `slope`     |                               |
| `geom_hline()`     | `yintercept`             |                               |
| `geom_vline()`     | `xintercept`             |                               |
| `geom_smooth()`    | `x`, `y`                 | `method`, `se`, `span`        |
| `geom_text()`      | `x`, `y`, `label`        | `parse`, `nudge_x`, `nudge_y` |

参数

| Code       | Description                              |
| ---------- | ---------------------------------------- |
| `x`        | Position on x-axis                       |
| `y`        | Position on y-axis                       |
| `shape`    | Shape                                    |
| `color`    | Color of border of elements              |
| `fill`     | Color of inside of elements              |
| `size`     | Size                                     |
| `alpha`    | Transparency (1: opaque; 0: transparent) |
| `linetype` | Type of line (e.g., solid, dashed)       |

Shape 散点的形状，1：25

[颜色](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf)

