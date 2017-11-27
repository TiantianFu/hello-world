library(testthat)
setwd("~/Desktop/stat133/stat133_github/stat133-hws-fall17/hw04")
source('code/functions.R')
#-----------------------------------------------
context("remove missing")
test_that("remove missing",{
  a<-c(1,4,7,NA,10)
  expect_equal(remove_missing(a),c(1,4,7,10))
  expect_identical(remove_missing(a),c(1,4,7,10))
  expect_false(length(remove_missing(a))==length(a))
  expect_true(length(remove_missing(a))==4)
})

#-----------------------------------------------
context("get_minimum")
test_that("get_minimum", {
  expect_equal(get_minimum(a),1)
  expect_identical(get_minimum(a),1)
  expect_equal(get_minimum(c(3,6,8)),3)
  expect_false(get_minimum(c(4,5,6))==6)
})

#-----------------------------------------------
context("get_maximum")
test_that("get_maximum", {
  expect_equal(get_maximum(a),10)
  expect_identical(get_maximum(a),10)
  expect_equal(get_maximum(c(5,6,7)),7)
  expect_true(get_maximum(a)==10)
})

#-----------------------------------------------
context("get_range")
test_that("get_range", {
  expect_equal(get_range(a),9)
  expect_identical(get_range(a),9)
  expect_true(get_range(a)==9)
  expect_false(get_range(a)==8)
})

#-----------------------------------------------
context("get_median")
test_that("get_median",{
  expect_equal(get_median(a),5.5)
  expect_identical(get_median(a),5.5)
  expect_true(get_median(a)==5.5)
  expect_false(get_median(a)==4)
})

#-----------------------------------------------
context("get_average")
test_that("get_average", {
  expect_equal(get_median(a),5.5)
  expect_identical(get_median(a),5.5)
  expect_true(get_median(a)==5.5)
  expect_false(get_median(a)==4)
})

#-----------------------------------------------
context("get_stdev")
test_that("get standard deviation ", {
  expect_false(get_stdev(a,na.rm = TRUE)==4)
  expect_false(get_stdev(a,na.rm = TRUE)==5)
  expect_false(get_stdev(a,na.rm = TRUE)==6)
  expect_error(get_stdev(e))
})

#-----------------------------------------------
  context("get_quartile1")
test_that("get the quartile 1 ", {
  expect_equal(as.numeric(get_quartile1(a,na.rm = TRUE)),3.25)
  expect_identical(as.numeric(get_quartile1(a,na.rm = TRUE)),3.25)
  expect_true(as.numeric(get_quartile1(a,na.rm = TRUE))==3.25)
  expect_false(as.numeric(get_quartile1(a,na.rm = TRUE))==4)
})

#-----------------------------------------------
context("get_quartile3")
test_that("get the quartile 3 ", {
  expect_equal(as.numeric(get_quartile3(a,na.rm = TRUE)),7.75)
  expect_identical(as.numeric(get_quartile3(a,na.rm = TRUE)),7.75)
  expect_true(as.numeric(get_quartile3(a,na.rm = TRUE))==7.75)
  expect_false(as.numeric(get_quartile3(a,na.rm = TRUE))==8)
})

#-----------------------------------------------
  context("count_missing")
test_that("count missing values", {
  expect_equal(count_missing(a),1)
  expect_error(count_missing(e))
  expect_true(count_missing(a)==1)
  expect_false(count_missing(a)==4)
})



#-----------------------------------------------
  context("summary_stats")
test_that("summary statistics", {
  expect_equal(length(summary_stats(a)),11)
  expect_true(length(summary_stats(a))==11)
  expect_false(length(summary_stats(a))==4)
  expect_error(summary_stats(e))
})

#-----------------------------------------------
  context("print_stats")
  test_that("print summarized statistics", {
    expect_error(print_stats(e))
    expect_false(length(print_stats(stats))==12)
    expect_true(length(print_stats(stats))==0)
})
#-----------------------------------------------
context("rescale number")
test_that("rescale number", {
  b <- c(18, 15, 16, 4, 17, 9) 
  expect_equal(rescale100(b,xmin=0,xmax=20),c(90,75,80,20,85,45))
  expect_identical(rescale100(b,xmin=0,xmax=20),c(90,75,80,20,85,45))
  expect_error(rescale100(e))
  expect_that(rescale100(b,xmin = 0,xmax = 20),equals(c(90,75,80,20,85,45)))
})

#-----------------------------------------------
  context("drop_lowestr")
test_that("drop_lowest", {
  x <- c(10, 10, 8.5, 4, 7, 9) 
  expect_equal(drop_lowest(x),c(10,10,9,8.5,7))
  expect_identical(drop_lowest(x),c(10,10,9,8.5,7))
  expect_error(drop_lowest(e))
  expect_that(drop_lowest(x),equals(c(10,10,9,8.5,7)))
})

#-----------------------------------------------
  context("score homework")
test_that("score homework", {
  x <- c(100, 80, 30, 70, 75, 85) 
  expect_equal(score_homework(x,drop=TRUE),82)
  expect_identical(score_homework(x,drop=TRUE),82)
  expect_error(score_homework(e))
  expect_that(score_homework(x,drop=TRUE),equals(82))
})

#-----------------------------------------------
  context("score quiz")
test_that("score quiz", {
  quizzes <- c(100, 80, 70, 0) 
  expect_equal(score_quiz(quizzes,drop=FALSE),62.5)
  expect_identical(score_quiz(quizzes,drop=FALSE),62.5)
  expect_error(score_quiz(e))
  expect_that(score_quiz(quizzes,drop=FALSE),equals(62.5))
})

#-----------------------------------------------
  context("score lab")
test_that("score lab", {
  quizzes <- c(100, 80, 70, 0) 
  expect_equal(score_lab(10),80)
  expect_identical(score_lab(10),80)
  expect_error(score_lab(e))
  expect_that(score_lab(10),equals(80))
})


