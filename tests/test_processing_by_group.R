
library(testthat)


context("check 'processing_by_group.R' result row and column number.")

test_that("Test process: data.frame row number",{
    df <- iris
    expected <- 3
    actual <- processingByGroupForML(df = df) %>% nrow()
    expect_equal(expected, actual)
})

test_that("Test process : data.frame colmun number",{
    df <- iris
    expected <- 2
    actual <- processingByGroupForML(df = df) %>% ncol()
    expect_equal(expected, actual)
})
