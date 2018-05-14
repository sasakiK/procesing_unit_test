
library(testthat)

source("R/processing.R")
source("R/processing_by_group.R")

# run test one by one -----------------------------------------------------


test_results <- test_dir("tests/", reporter="summary")

source("tests/test_processing.R")

# run test automaticaly ---------------------------------------------------


auto_test(code_path = "R/", test_path = "tests/", reporter = default_reporter(),
          env = test_env(), hash = TRUE)
