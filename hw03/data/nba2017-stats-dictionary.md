---
title: "nba2017-stats-dictionary.md"
output: html_document
---
- `player`: name of the player.
- `team`: 3-letter team abbreviation.
- `position`: player position.
- `experience`: years of experience.
- `salary`: salary (in dollars).
- `rank`:Rank of player in his team
- `points`: total scored points.
- `MIN':Minutes Played during regular season
- `FGM`:Field Goals Made
- `FGA`:Field Goal Attempts
- `FTM`:Free Throws Made
- `FTA`:Free Throws Attempts
- `points1`: number of free throws, worth 1 point each.
- `points2`: number of 2-point field goals, worth 2 points each.
- `points3`: number of 3-point field goals, worth 3 points each.
- `ORED`:Offensive Rebounds
- `DREB`:Defensive Rebounds
- `AST`:Assists
- `STL`:Steals
- `BLK`:Blocks
- `TO`:Turnovers


numbers of Rows:441
numbers of Columns:22

main source: www.basketball-reference.com

The values in `points` result from adding all scored points:

```r
points1 + (2 * points2) + (3 * points3)
```

Although each object has its own data type, you can think of each of them as a variable from a statistics standpoint like so:

| Object       | Variable     |
|:-------------|:-------------|
| `player`     | categorical  |
| `team`       | categorical  |
| `position`   | categorical  |
| `experience` | quantitative |
| `salary`     | quantitative |
| `points`     | quantitative |
| `points1`    | quantitative |
| `points2`    | quantitative |
| `points3`    | quantitative |


```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
