#-------------------------------------------------------
#Function remove_missing()
#' @title remove missing
#' @description remove missing values in a vector
#' @param x a numeric vector
#' @return vector with no missing values
  remove_missing <- function(x, na.rm = FALSE) {
    x <- x[!is.na(x)]
    return(x)
  }

#------------------------------------------------------
#Function get_minimum()
#' @title get_minimum
#' @description get the minimun value of a vector
#' @param x a numeric vector
#' @return the minumen value of a vector
   get_minimum <- function(x,na.rm = FALSE) {
     stopifnot(is.numeric(x))
     if (na.rm){
       x<-remove_missing(x)
     }
     x=sort(x,decreasing=FALSE)[1]
     return(x)
   }
 
#------------------------------------------------------
#Function get_maximum()
#'@title get_maximum
#'@description get the max of a vector
#'@param x a numeric vector
#'@return the max value of a vector
  get_maximum <- function(x,na.rm =FALSE) {
    stopifnot(is.numeric(x))
    if (na.rm){
      x<-remove_missing(x)
    }
    x=sort(x,decreasing=TRUE)[1]
    return(x)
  }

#----------------------------------------------------
#Function get_range()
#'@title get_range
#'@description get the range out of a vector
#'@param x a numeric vector
#'@return the range of a vector 
 get_range <- function(x,na.rm = FALSE) {
   stopifnot(is.numeric(x))
   if (na.rm){
     x<-remove_missing(x)
   }
   x=get_maximum(x)-get_minimum(x)
   return(x)
 }
  
#------------------------------------------------------
#Function get_median()
#'@title get_median 
#'@description get the median value of a vector
#'@param x a numeric vector
#'@return the median of a vector
get_median <- function(x, na.rm = FALSE) {
  stopifnot(is.numeric(x))
      if (na.rm) {
        x<-remove_missing(x)
      }
      x = sort(x, decreasing = FALSE)

      if (length(x) %% 2 == 0) {
        x = (x[length(x)/ 2] + x[(length(x)/ 2) + 1])/2
        return(x)
        
      } else{
        x = x[(length(x) + 1) / 2]
        return(x)
      }
      
}
 
#-----------------------------------------------------------
#Function get_average()
#'@title get_average
#'@description get the average value of a vector
#'@param x a numeric vector
#'@return the average value of a vector
    get_average <- function(x, na.rm = FALSE) {
      stopifnot(is.numeric(x))
      if (na.rm) {
        x<-remove_missing(x)
       
      }
        sum <- 0
        for (i in 1:length(x)) {
          sum <-  sum + x[i]
          }
        x <- sum / length(x)
        return(x)
    }

 
#--------------------------------------------------
#Function get_stdev
#'@title get standard deviation 
#'@description get standard deviation of a vector
#'@param x is a numeric vector
#'@return the standard deviation of a vector
get_stdev<-function(x,na.rm = FALSE) {
  stopifnot(is.numeric(x))
  if (na.rm) {
    x<-remove_missing(x)
    
  }
  deviations <- 0
  for (i in 1:length(x)) {
    deviations <- deviations + (x[i] - get_average(x))^2
  }
    x=sqrt(deviations / (length(x) - 1))
    return(x)
}

#--------------------------------------------------
#Function get_quartile1
#'@title get the quartile 1 
#'@description get the quartile one of a vector
#'@param x is a numeric vector
#'@return the first quartile of a vector
get_quartile1 <-function(x,na.rm =FALSE){
  stopifnot(is.numeric(x))
  if (na.rm) {
    x<-remove_missing(x)
  }
  x=quantile(x,0.25)
  return(x)
}

#-------------------------------------------------
#Function get_quartile3
#'@title get the quartile 3 
#'@description get the third quartile of a vector
#'@param x is a numeric vector
#'@return the third quartile of a vector
get_quartile3 <-function(x,na.rm =FALSE){
  stopifnot(is.numeric(x))
  if (na.rm) {
    x<-remove_missing(x)
  }
  x=quantile(x,0.75)
  return(x)
}

#------------------------------------------------
#Function count_missing
#'@title count missing values
#'@description count missing values of a vector
#'@param is a numeric vector
#'@return the number of missing values in a vector
count_missing <- function(x,na.rm =FALSE){
  x=sum(is.na(x))
  return(x)
}

#-----------------------------------------------
#Function summary_stats
#'@title summary statistics
#'@description summary several statistics by using the functions created before
#'@param is a numeric vector
#'@return summary statistics
percent10 <-function(x,na.rm =FALSE){
  if (na.rm) {
    x<-remove_missing(x)
  }
  x=quantile(x,0.10)
  return(x)
}
percent90 <-function(x,na.rm =FALSE){
  if (na.rm) {
    x<-remove_missing(x)
  }
  x=quantile(x,0.90)
  return(x)
}
summary_stats <- function(x,na.rm=FALSE){
  summary_stats <- list(
    
  minimum = get_minimum(x,na.rm=TRUE),
  percent10 = as.numeric (percent10(x,na.rm=TRUE)),
  quartile1 = as.numeric (get_quartile1(x,na.rm=TRUE)),
  median = get_median(x,na.rm=TRUE),
  mean = get_average(x,na.rm=TRUE),
  quartile3 = as.numeric (get_quartile3(x,na.rm=TRUE)),
  percent90 = as.numeric (percent90(x,na.rm=TRUE)),
  maximum = get_maximum(x,na.rm=TRUE),
  range = get_range(x,na.rm=TRUE),
  stdev = get_stdev(x,na.rm=TRUE),
  missing = count_missing(x)
  )
  return(summary_stats)
}

#-----------------------------------------------
#Function print_stats
#'@title print summarized statistics
#'@description print summarized statistics in a nice format
#'@param is a numeric list 
#'@return printed summary
 
  print_stats <- function(x){
    names <- format(names(x), width = max(nchar(names(x))))
    x <- as.numeric(x)
    x <- format(round(x, 4), nsmall = 4)
    for (i in 1:length(x)) {
      cat(paste(names[i], ":", x[i], sep =""), "\n")
    }
  }

#-----------------------------------------------
#Function rescale100
#'@title rescale number
#'@description rescale numbers in a vector
#'@param is a numeric list 
#'@return rescaled numbers
rescale100 <- function(x,xmin,xmax){
  x=100*(x-xmin)/(xmax-xmin)
  return(x)
}

#-----------------------------------------------
#Function drop_lowest
#'@title drop_lowest
#'@description drop the lowest number
#'@param is a numeric list 
#'@return a new vector
drop_lowest <- function(x) {
  x = sort(x, decreasing = TRUE)
  x = x[1:(length(x)-1)]
  return(x)
}

#-----------------------------------------------
#Function score_homework
#'@title score homework
#'@description score homework either with droping or without droping the scores
#'@param is a numeric list 
#'@return scored homework
score_homework <- function(x,drop=TRUE){
  if (drop==TRUE) {
    x<- drop_lowest(x)
    x<- get_average(x)
    return(x)
  }else if(drop==FALSE){
    x<- get_average(x)
    return(x)
  }
}

#-----------------------------------------------
#Function score_quiz
#'@title score quiz
#'@description score quiz either with droping or without droping the scores
#'@param is a numeric list 
#'@return scored quiz
score_quiz <- function(x,drop=TRUE){
    if (drop==TRUE) {
      x<- drop_lowest(x)
      x<- get_average(x)
      return(x)
    }else if(drop==FALSE){
      x<- get_average(x)
      return(x)
    }
  }

#-----------------------------------------------
#Function score_lab
#'@title score lab
#'@description score lab with different range of attendence
#'@param is a numeric list 
#'@return scored lab
score_lab <- function(x) {
    if ((x == 11) |(x == 12)) {
      return(100)
    } else if (x == 10) {
      return(80)
    } else if (x == 9) {
      return(60)
    } else if (x == 8) {
      return(40)
    } else if (x == 7) {
      return(20)
    } else if (x <= 6) {
        return(0)
      }
  }

