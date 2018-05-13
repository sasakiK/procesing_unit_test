
# Description -------------------------------------------------------------

#' @ Description:define function for preprocessing(testthat package)
#' @ Auther     :SASAKI KENSUKE
#' @ Date       :2018.05.13
#' @ Note       :ref : http://testthat.r-lib.org/
#' @ Note       :ref : http://www.brodrigues.co/blog/2016-03-31-unit-testing-with-r/

# load modules ------------------------------------------------------------

library(dplyr)
library(testthat)

# Define function & objects ---------------------------------------------------------


# sample functoin
processingForML <- function(df){
    #
    # Args:
    #  df : (df)
    #
    # Returns:
    #  processed (df)

    proccessed <- df %>% bind_rows(df)
    return(proccessed)
}



# processing ----------------------------------------------------------------

processingForML(iris)
