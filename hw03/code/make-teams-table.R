# ======================================================
# Title:Ranking 
# Description:
#
#
# Input(s):
# Output(S):
# Author:Tiantian Fu
# Date:10/6/2017
# ======================================================
install.packages(c("dplyr","ggplot2"))
library(readr)
library(ggplot2)
library(dplyr)

dat_roster<- read.csv('../data/nba2017-roster.csv')
dat_stats <- read.csv('../data/nba2017-stats.csv')


#Adding new variables

dat_stats1<-mutate(dat_stats,missed_fg=field_goals_atts-field_goals_made,
       missed_ft=points1_atts-points1_made,
       points=1*points1_made+2*points2_made+3*points3_made,
       rebounds=off_rebounds+def_rebounds,
       efficiency=(points+rebounds+assists+blocks+steals-missed_fg-missed_ft-turnovers)/games_played)


sink(file='../output/efficiency-summary.txt')
summary(dat_stats1$efficiency)
sink()

#Merging Tables
dat_new<-merge(dat_stats1,dat_roster)

#Creating nba2017-teams.csv

teams <- summarise(
  group_by(dat_new,team),
  sum_ex=round(sum(experience),2),
  sum_salary=round(sum(salary)/1000000,2),
  sum_points3=sum(points3_made),
  sum_points2=sum(points2_made),
  sum_ft=sum(points1_made),
  sum_points=sum(points),
  sum_off=sum(off_rebounds),
  sum_def=sum(def_rebounds),
  sum_assist=sum(assists),
  sum_steals=sum(steals),
  sum_blocks=sum(blocks),
  sum_turn=sum(turnovers),
  sum_fouls=sum(fouls),
  sum_eff=sum(efficiency)
  )
teams$team <- as.vector(teams$team)
summary(teams)


sink(file='../output/teams-summary.txt')
summary(teams)
sink()

write.csv(teams,file = '../data/nba2017-teams.csv')

#Some graphics

pdf(file='../images/teams_star_plot.pdf')
stars(teams[ ,-1],labels=teams$team)
dev.off()

gg_ex_salary <- ggplot(data = teams,aes(x=sum_ex,y=sum_salary))+
  geom_point()+
  geom_text(aes(label=team))
ggsave(filename = '../images/experience_salary.pdf',
       plot = gg_ex_salary)
gg_ex_salary


