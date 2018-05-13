
# Description -------------------------------------------------------------

#' @ Description:前処理に関して、モジュールごとにunittestをする(testthat package)
#' @ Auther     :SASAKI KENSUKE
#' @ Date       :2018.0.10d
#' @ Note       :ref : https://github.com/smbache/ensurer
#' @ Note       :ref : https://cran.r-project.org/web/packages/ensurer/vignettes/ensurer.html


# load modules ------------------------------------------------------------

library(dplyr)
library(magrittr)
library(ensurer)


# Define function & objects ---------------------------------------------------------

# test function
function_ex <- function(inpur){
    # load faster and rename japanese varnames
    # Args:
    #  input : (character)
    #
    # Returns:
    #  returns (data.frame)

}

# Processing --------------------------------------------------------------


# Basic Examples -------------------------------------------------

# To reference the value being evaluated, use the `.` placeholder.
# 評価される値を参照するには、(.)を使う
ensure_square <- ensures_that(NCOL(.) == NROW(.))

# try it out:

# passes case : return the diagnal matrix
# テストをpassするケース : diag(5)が出力される

diag(5)
# [,1] [,2] [,3] [,4] [,5]
# [1,]    1    0    0    0    0
# [2,]    0    1    0    0    0
# [3,]    0    0    1    0    0
# [4,]    0    0    0    1    0
# [5,]    0    0    0    0    1

diag(5) %>%
    ensure_square


# not pass case : an error is raised.
# テストをpassしないケース ： エラーが出力される

matrix(1:20, 4, 5)
# [,1] [,2] [,3] [,4] [,5]
# [1,]    1    5    9   13   17
# [2,]    2    6   10   14   18
# [3,]    3    7   11   15   19
# [4,]    4    8   12   16   20

matrix(1:20, 4, 5) %>%
    ensure_square
# --- error massages ---
# Error: conditions failed for call 'matrix(1:20, 4, 5) %>% ensure_square':
#     * NCOL(.) == NROW(.)

# On the fly contracts:
matrix(1:4, 2, 2) %>%
    ensure_that(is.matrix(.), all(is.numeric(.)))


# several condition can add
ensure_square <- ensures_that(is.matrix,
                              NCOL(.) == NROW(.))



# type and type-sage functions -------------------------

# type safe function

f <- function_(a ~ integer, b ~ character: "Hello, World!", {
    rep(b, a)
})

f(10) # fails
# --- error massages ---
# Error: conditions failed for call 'f(10)':
#     * Value is not an integer (vector)

f(10L) # works
# [1] "Hello, World!" "Hello, World!"
# [3] "Hello, World!" "Hello, World!"
# [5] "Hello, World!" "Hello, World!"
# [7] "Hello, World!" "Hello, World!"
# [9] "Hello, World!" "Hello, World!"

f(10L, "foo")
# [1] "foo" "foo" "foo" "foo" "foo" "foo" "foo"
# [8] "foo" "foo" "foo"

type_lm <- ensures_that("lm" %in% class(.) ~ "Value is not a linear model.")
safe_lmsummary <- function_(model ~ lm, {
    summary(model)
})

safe_lmsummary(lm(Sepal.Length ~ ., iris))
# Call:
#     lm(formula = Sepal.Length ~ ., data = iris)
#
# Residuals:
#     Min       1Q   Median       3Q      Max
# -0.79424 -0.21874  0.00899  0.20255  0.73103
#
# Coefficients:
#     Estimate Std. Error t value
# (Intercept)        2.17127    0.27979   7.760
# Sepal.Width        0.49589    0.08607   5.761
# Petal.Length       0.82924    0.06853  12.101
# Petal.Width       -0.31516    0.15120  -2.084
# Speciesversicolor -0.72356    0.24017  -3.013
# Speciesvirginica  -1.02350    0.33373  -3.067
# Pr(>|t|)
# (Intercept)       1.43e-12 ***
#     Sepal.Width       4.87e-08 ***
#     Petal.Length       < 2e-16 ***
#     Petal.Width        0.03889 *
#     Speciesversicolor  0.00306 **
#     Speciesvirginica   0.00258 **
#     ---
#     Signif. codes:
#     0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
# Residual standard error: 0.3068 on 144 degrees of freedom
# Multiple R-squared:  0.8673,	Adjusted R-squared:  0.8627
# F-statistic: 188.3 on 5 and 144 DF,  p-value: < 2.2e-16



# Special features include -------------------------

# ・Customizing error behavior
# ・Easily combining several contracts
# ・Customizing error description
# ・Customizing individual conditions' error messages






# Vignette ----------------------------------------------------------------

# refs / https://cran.r-project.org/web/packages/ensurer/vignettes/ensurer.html

# Two function to remember : 覚えておく二つの関数

# ensure_that:  function(., ..., fail_with, err_desc)  [short-hand alias: ensure]
# ensures_that: function(..., fail_with, err_desc)     [short-hand alias: ensures]

# define supposing function
get_matrix <- function(size) {
    return(diag(size))
}

get_factorial_matrix <- function(size) {
    return(diag(size * size))
}


the_matrix <- get_matrix(3) %>%
    ensure_that(is.numeric(.), NCOL(.) == NROW(.))

# upper is not work, but the second can
test <- ensure_that(is.numeric(.), NCOL(.) == NROW(.))
test <- ensures_that(is.numeric(.), NCOL(.) == NROW(.))

ensure_square_numeric <- ensures_that(NCOL(.) == NROW(.), is.numeric(.))

m1 <- get_matrix(3) %>% ensure_square_numeric
m2 <- get_factorial_matrix(3) %>% ensure_square_numeric


# Only the first error is recorded.
letters %>%
    ensure_that(length(.) == 10) %>%
    ensure_that(all(. == toupper(.)))

# Both errors are recorded.
letters %>%
    ensure_that(length(.) == 10, all(. == toupper(.)))


if (check_that(my_sequence, is.numeric)){
    message("Success!")
}

matrix_is_square <- ensures_that(NROW(.) == NCOL(.))
all_positive     <- ensures_that(all(. > 0))


matrix(runif(16), 4, 4) %>%
    ensure(+matrix_is_square, +all_positive)
# [,1]      [,2]      [,3]      [,4]
# [1,] 0.01969727 0.8979534 0.8464475 0.1348471
# [2,] 0.33271668 0.9447982 0.6144247 0.3618926
# [3,] 0.41707243 0.6660964 0.6556034 0.4928892
# [4,] 0.88751901 0.6084515 0.9772431 0.3236367



# add messages
ensure_character <-
    ensures_that(is.character(.) ~ "vector must be of character type.")

1:10 %>% ensure_character
# Error: conditions failed for call '1:10 %>% ensure_character':
#     * vector must be of character type.



# Ensuring function return values

`: numeric` <- ensures_that(is.numeric(.))

get_quote <- function(ticker) `: numeric`({
    # some code that extracts latest quote for the ticker
})


`: square matrix` <- ensures_that(is.numeric(.),
                                  is.matrix(.),
                                  NCOL(.) == NROW(.))

var_covar <- function(vec) `: square matrix`({
    # some code that produces a variance-covariance matrix.
})




square_failure <- function(e)
{
    # suppose you had an email function:
    email("maintainer@company.com", subject = "error", body = e$message)
    stop(e)
}

m1 <- get_matrix() %>%
    ensure_that(
        NCOL(.) == NROW(.),
        is.numeric(.),
        fail_with = square_failure)

m2 <-
    get_matrix(3) %>%
    ensure_that(
        NCOL(.) == NROW(.),
        is.numeric(.),
        fail_with = diag(10))


square_failure <- function(e)
{
    # fetch the dot.
    . <- get(".", parent.frame())

    # compose a message detailing also the class of the object returned.
    msg <-
        sprintf("Here is what I know:\n%s\nValue class: %s.",
                e$message,
                class(.) %>% paste(collapse = ", ")) # there could be several.

    # suppose you had an email function:
    email("maintainer@company.com", subject = "error", body = msg)

    stop(e)
}






iris_template <-
    data.frame(
        Sepal.Length = numeric(0),
        Sepal.Width  = numeric(0),
        Petal.Length = numeric(0),
        Petal.Width  = numeric(0),
        Species      =
            factor(numeric(0), levels = c("setosa", "versicolor", "virginica"))
    )

ensure_as_template <- function(x, tpl){
    ensure_that(x,
                is.data.frame(.),
                identical(class(.), class(tpl)),
                identical(sapply(., class), sapply(tpl, class)),
                identical(sapply(., levels), sapply(tpl, levels))
    )
}
iris %>% ensure_as_template(iris_template)





# save rds ----------------------------------------------------------------


