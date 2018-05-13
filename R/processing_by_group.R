
# Description -------------------------------------------------------------

#' @ Description:define function for preprocessing by group(testthat package)
#' @ Auther     :SASAKI KENSUKE
#' @ Date       :2018.05.13
#' @ Note       :ref : http://testthat.r-lib.org/
#' @ Note       :ref : http://www.brodrigues.co/blog/2016-03-31-unit-testing-with-r/

# load modules ------------------------------------------------------------

library(dplyr)
library(testthat)

# Define function & objects ---------------------------------------------------------


# sample functoin
processingByGroupForML <- function(df){
    #
    # Args:
    #  df : (df)
    #
    # Returns:
    #  processed (df)

    proccessed <- df %>% group_by(Species) %>%
        summarize_at(vars(Sepal.Length), funs(sum))
    return(proccessed)
}



# processing ----------------------------------------------------------------

processingByGroupForML(iris)
