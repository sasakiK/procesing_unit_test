
library(testthat)


context("check 'processing.R' result row number.")
test_that("Test process: data.frame row number",{
    df <- iris
    expected <- nrow(iris) * 2
    actual <- processForML(df = df) %>% nrow()
    expect_equal(expected, actual)
})

context("check processing result column number.")
test_that("Test process: data.frame colmun number",{
    df <- iris
    expected <- ncol(iris)
    actual <- processForML(df = df) %>% ncol()
    expect_equal(expected, actual)
})
