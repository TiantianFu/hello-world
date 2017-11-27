# test script
setwd("~/Desktop/stat133/stat133_github/stat133-hws-fall17/hw04")
library(testthat)
# source in functions to be tested
source('code/functions.R')
sink('output/test-reporter.txt')
test_file('code/tests.R')
sink()