# ======================================================
# Title:Cleaning Data 
# Description:This script performs cleaning tasks and transformations on 
# various columns of the raw data file.
# Input(s):data file 'rawscores.csv'
# Output(s):data file 'clean-data.csv'
# Author:Tiantian Fu
# Date:11/26/2017
# ======================================================

setwd("~/Desktop/stat133/stat133_github/stat133-hws-fall17/hw04")
library(readr)
library(stringr)
library(dplyr)
source('code/functions.R')

#read in the CSV file with the raw scores
dat <-read.csv('data/rawdata/rawscores.csv')
sink(file='output/summary-rawscores.txt')
str(dat)
sink()

#write a for() loop, traversing the columns of the data frame, 
#to replace all missing values NA with zero.
for(i in 1:ncol(dat)){
  dat[is.na(dat[,i]), i] <- 0
}

#use rescale100() to rescale QZ1: 0 is the minimum, and 12 is the max.
dat$QZ1<-rescale100(dat$QZ1,xmin = 0,xmax = 12)

#use rescale100() to rescale QZ2: 0 is the minimum, and 18 is the max.
dat$QZ2<-rescale100(dat$QZ2,xmin = 0,xmax = 18)

#use rescale100() to rescale QZ3: 0 is the minimum, and 20 is the max.
dat$QZ3<-rescale100(dat$QZ3,xmin = 0,xmax = 20)

#use rescale100() to rescale QZ4: 0 is the minimum, and 20 is the max.
dat$QZ4<-rescale100(dat$QZ4,xmin = 0,xmax = 20)

#use rescale100() to add a variable Test1 by rescaling
#EX1: 0 is the minimum, and 80 is the max.
Test1<-as.numeric(rescale100(dat$EX1,xmin = 0,xmax = 80))
dat<-cbind(dat,Test1)

# use rescale100() to add a variable Test2 by rescaling 
#EX2: 0 is the minimum, and 90 is the max.
Test2<-as.numeric(rescale100(dat$EX2,xmin = 0,xmax = 90))
dat<-cbind(dat,Test2)

#add a variable Homework to the data frame of scores; 
#this variable should contain the overall homework score 
#obtained by dropping the lowest HW, and then averaging the remaining scores
dat_HW <- dat[,1:9]
Homework<-matrix(data=NA,nrow = 334,ncol = 1)
for (i in 1:334) {
 Homework[i,1]<-(round(apply(dat_HW[i,], 1, score_homework),2))
  
}
dat<-cbind(dat,Homework)

#add a variable Quiz to the data frame of scores; this variable should contain
#the overall quiz score obtained by dropping the lowest quiz, and then averaging 
#the remaining scores.
dat_Quiz <-dat[,11:14]
Quiz<-matrix(data=NA,nrow = 334,ncol = 1)
for (i in 1:334) {
  Quiz[i,1]<-round(apply(dat_Quiz[i,], 1, score_quiz),2)
  
}
dat<-cbind(dat,Quiz)

#lab score changing 
dat_att <- dat[,10]
lab<-matrix(data = NA,nrow = 334,ncol = 1)
for (i in 1:334) {
  lab[i,1]<-score_lab(dat_att[i])
}
dat<-cbind(dat,lab)
#add a variable Overall to the data frame of scores; 
#this variable should be calculated using the following grading structure:
overall <- matrix(data = NA,nrow = 334,ncol = 1)
for (i in 1:334) {
  overall[i,1]<-round((dat[i,21]*0.1+dat[i,19]*0.3+dat[i,20]*0.15+dat[i,17]*0.2+dat[i,18]*0.25),2)
  
}
dat<-cbind(dat,overall)

#calculate a variable Grade (and add it to the data frame of scores)
Grade <- matrix(data = NA, nrow = 334, ncol = 1)
for (i in 1:334) {
  if ((dat[i, 22] > 0 ) & (dat[i, 22] <50)) {
    Grade[i, 1] <- 'F'
  } else if ((dat[i, 22] >= 50) & (dat[i, 22] <60)) {
    Grade[i, 1] <- 'D'
  } else if ((dat[i, 22] >= 60) & (dat[i, 22] <70)) {
    Grade[i, 1] <- 'C-'
  } else if ((dat[i, 22] >= 70) & (dat[i, 22] <77.5)) {
    Grade[i, 1] <- 'C'
  } else if ((dat[i, 22] >= 77.5) & (dat[i, 22] <79.5)) {
    Grade[i, 1] <- 'C+'
  } else if ((dat[i, 22] >= 79.5) & (dat[i, 22] <82)) {
    Grade[i, 1] <- 'B-'
  } else if ((dat[i, 22] >= 82) & (dat[i, 22] <86)) {
    Grade[i, 1] <- 'B'
  } else if ((dat[i, 22] >= 86) & (dat[i, 22] <88)) {
    Grade[i, 1] <- 'B+'
  } else if ((dat[i, 22] >= 88) & (dat[i,22] <90)) {
    Grade[i, 1] <- 'A-'
  } else if ((dat[i, 22] >= 90) & (dat[i, 22] <95)) {
    Grade[i, 1] <- 'A'
  } else if ((dat[i, 22] >= 95) & (dat[i, 22] <100)) {
    Grade[i, 1] <- 'A+'
  }
}
dat<-cbind(dat,Grade)
#write a for loop in which you use your functions
#summary_stats() and print_stats() to export, via sink()
files<-c("lab","Homework","Quiz","Test1","Test2","overall")
for (i in 1:6) {
sink(paste0('output/',files[i],'-stats.txt'))
n<- unlist(summary_stats(dat[,files[i]]),use.names = TRUE)
print_stats(n)
sink()
}

#sink()thestructurestr()
#ofthedataframeofcleanscorestoafilesummary-cleanscores.txt,
#inside the output/ folder.
sink(file='output/summary-cleanscores.txt')
str(dat)
sink()

#Finally, export the clean data frame of scores to a CSV file
#cleanscores.csv inside the folder data/cleandata/. 
#This data set should contain 334 rows, and 23 columns.
write.csv(dat,file = 'data/cleandata//cleanscores.csv')

grade <- cut(dat$overall,
             breaks=c(0,50,60,70,77.5,79.5,82,86,88,90,95,100),
             labels = c("F","D","C-","C","C+","B-","B","B+","A-",
                        "A","A+"),
             right=TRUE
)




grade_table <- dat %>% 
  group_by(Grade) %>%
  summarise(count=n()) %>%
  mutate(prop=count/sum(count))



grade_table$Grade <- factor(grade_table$Grade,levels = c("A+","A","A-","B+","B","B-",
                                                         "C+","C","C-","D","F"))
