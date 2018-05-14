
library(testthat)

context("check 'processing.R' result row and column number.")

test_that("Test process: data.frame row number",{
    df <- iris
    expected <- nrow(iris) * 2
    actual <- processingForML(df = df) %>% nrow() + 1
    expect_equal(expected, actual)
})

test_that("Test process: data.frame colmun number",{
    df <- iris
    expected <- ncol(iris)
    actual <- processingForML(df = df) %>% ncol()
    expect_equal(expected, actual)
})
