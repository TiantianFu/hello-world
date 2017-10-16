---
title: "nba2017-roster-dictionary.md"
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
numbers of Columns:8

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

